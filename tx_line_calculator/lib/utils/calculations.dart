import 'dart:math';
import 'package:complex/complex.dart';
import 'package:flutter/foundation.dart';
import 'package:tx_line_calculator/utils/constants.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

// MUST STILL CALCULATE GENERAL MU AND SIGMA

class Calculations {
/*
  EVALUATE BTN CALCULATIONS
*/

// evaluate coaxial params
  static Future<void> evalCoaxial(int geometry, double a, double b) async {
    double? muC = await UserInputData.getMuC();
    double? sigmaC = await UserInputData.getSigmaC();
    double? f = await UserInputData.getF();
    double? muR = await UserInputData.getMuR();
    // conditional
    double mu = muR! * Constants.mu0;
    double? epsilonR = await UserInputData.getEpsilonR();
    double epsilon = epsilonR! * Constants.epsilon0;
    double? sigma = await UserInputData.getSigma();

    double rS = calcRs(muC!, sigmaC!, f!);
    double r = calcRCoaxial(rS, a, b);
    double l = calcLCoaxial(muR!, a, b);
    double g = calcGCoaxial(sigma!, a, b);
    double c = calcCCoaxial(epsilon, a, b);

    await UserInputData.saveCoaxialResults(rS, r, l, g, c);

    await calcPropConstants();
  }

// evaluate 2-wire params
  static Future<void> eval2Wire(int geometry, double D, double d) async {
    double? muC = await UserInputData.getMuC();
    double? sigmaC = await UserInputData.getSigmaC();
    double? f = await UserInputData.getF();
    double? muR = await UserInputData.getMuR();
    // conditional
    double mu = muR! * Constants.mu0;
    double? epsilonR = await UserInputData.getEpsilonR();
    double epsilon = epsilonR! * Constants.epsilon0;
    double? sigma = await UserInputData.getSigma();

    double rS = calcRs(muC!, sigmaC!, f!);
    double r = calcR2Wire(rS, d);
    double l = calcL2Wire(muR!, D, d);
    double g = calcG2Wire(sigma!, D, d);
    double c = calcC2Wire(epsilon, D, d);

    await UserInputData.save2WireResults(rS, r, l, g, c);

    await calcPropConstants();
  }

// evaluate parallel plate params
  static Future<void> evalParallelPlate(
      int geometry, double w, double h) async {
    double? muC = await UserInputData.getMuC();
    double? sigmaC = await UserInputData.getSigmaC();
    double? f = await UserInputData.getF();
    double? muR = await UserInputData.getMuR();
    // conditional
    double mu = muR! * Constants.mu0;
    double? epsilonR = await UserInputData.getEpsilonR();
    double epsilon = epsilonR! * Constants.epsilon0;
    double? sigma = await UserInputData.getSigma();

    double rS = calcRs(muC!, sigmaC!, f!);
    double r = calcRParallel(rS, w);
    double l = calcLParallel(muR!, w, h);
    double g = calcGParallel(sigma!, w, h);
    double c = calcCParallel(epsilon, w, h);

    await UserInputData.saveParallelPlateResults(rS, r, l, g, c);

    await calcPropConstants();
  }

// calc gamma, alpha, beta
  static Future<void> calcPropConstants() async {
    double? r = await UserInputData.getR();
    double? l = await UserInputData.getL();
    double? g = await UserInputData.getG();
    double? c = await UserInputData.getC();
    double? f = await UserInputData.getF();

    debugPrint('r: $r, l: $l, g: $g, c: $c, f: $f');

    Complex gamma = calcGamma(r!, l!, g!, c!, f!);
    double alpha = calcAlpha(gamma);
    double beta = calcBeta(gamma);

    await UserInputData.savePropConstants(alpha, beta);
  }

/*
  RELEVANT FORMULAE:
*/

// calculate complex propagation constant (gamma)
  static Complex calcGamma(double r, double l, double g, double c, double f) {
    double omega = 2 * pi * f;
    Complex term1 = Complex(r, omega * l); // R' + jωL'
    Complex term2 = Complex(g, omega * c); // G' + jωC'
    Complex gamma = (term1 * term2).sqrt();

    debugPrint('term1: $term1, term2: $term2, gamma: $gamma');

    return gamma;
  }

// calculate attenuation constant (alpha)
  static double calcAlpha(Complex gamma) {
    return gamma.real;
  }

// calculate phase constant (beta)
  static double calcBeta(Complex gamma) {
    return gamma.imaginary;
  }

// calculate characteristic impedance (z0)

// calculate phase velocity (v)

// calculate wavelength (lambda)

// calculate Rs
  static double calcRs(double muC, double sigmaC, double f) {
    return sqrt((pi * f * muC) / sigmaC);
  }

// calculate R'
  static double calcRCoaxial(double rS, double a, double b) {
    return (rS / (2 * pi)) * ((1 / a) + (1 / b));
  }

  static double calcR2Wire(double rS, double d) {
    return (2 * rS) / (pi * d);
  }

  static double calcRParallel(double rS, double w) {
    return (2 * rS) / w;
  }

// calculate L'
  static double calcLCoaxial(double mu, double a, double b) {
    return (mu / (2 * pi)) * log(b / a);
  }

  static double calcL2Wire(double mu, double D, double d) {
    double ratio = D / d;
    return (mu / pi) * log(ratio + sqrt(pow(ratio, 2) - 1));
  }

  static double calcLParallel(double mu, double w, double h) {
    return (mu * h) / w;
  }

// calculate G'
  static double calcGCoaxial(double sigma, double a, double b) {
    return (2 * pi * sigma) / log(b / a);
  }

  static double calcG2Wire(double sigma, double D, double d) {
    double ratio = D / d;
    return (pi * sigma) / log(ratio + sqrt(pow(ratio, 2) - 1));
  }

  static double calcGParallel(double sigma, double w, double h) {
    return (sigma * w) / h;
  }

// calculate C'
  static double calcCCoaxial(double epsilon, double a, double b) {
    return (2 * pi * epsilon) / log(b / a);
  }

  static double calcC2Wire(double epsilon, double D, double d) {
    double ratio = D / d;
    return (pi * epsilon) / log(ratio + sqrt(pow(ratio, 2) - 1));
  }

  static double calcCParallel(double epsilon, double w, double h) {
    return (epsilon * w) / h;
  }
}

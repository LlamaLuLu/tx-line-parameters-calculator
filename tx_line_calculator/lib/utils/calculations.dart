import 'dart:math';
import 'package:complex/complex.dart';
import 'package:flutter/foundation.dart';
import 'package:tx_line_calculator/utils/constants.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class Calculations {
// ======================= EVALUATE BTN CALCULATIONS ========================

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
  }

// evaluate microstrip params & prop constants
  static Future<void> evalMicrostrip(
      int geometry, double wMicro, double hMicro) async {
    double? f = await UserInputData.getF();
    double omega = 2 * pi * f!;
    double? epsilonR = await UserInputData.getEpsilonR();

    double sRatio = calcSRatio(wMicro, hMicro);
    double epsilonEff =
        calcEpsilonEff(epsilonR!, sRatio, calcX(epsilonR), calcY(sRatio));
    double z0Micro = calcZ0Micro(epsilonEff, wMicro, hMicro);

    double r = 0;
    double g = 0;
    double c = epsilonEff / (z0Micro * Constants.c);
    double l = c * pow(z0Micro, 2);
    double alpha = 0;
    double beta = (omega / Constants.c) * sqrt(epsilonEff);

    await UserInputData.saveMicrostripResults(r, l, g, c);
    await UserInputData.savePropConstants(alpha, beta);
    await UserInputData.saveZ0Lossless(z0Micro);
  }

// ========================= GROUP CALCULATIONS ==========================

// calc gamma, alpha, beta
  static Future<void> calcPropConstants() async {
    double? r = await UserInputData.getR();
    double? l = await UserInputData.getL();
    double? g = await UserInputData.getG();
    double? c = await UserInputData.getC();
    double? f = await UserInputData.getF();

    //debugPrint('r: $r, l: $l, g: $g, c: $c, f: $f');

    Complex gamma = calcGamma(r!, l!, g!, c!, f!);
    double alpha = calcAlpha(gamma);
    double beta = calcBeta(gamma);

    await UserInputData.savePropConstants(alpha, beta);
  }

// calc z0
  static Future<void> calcZ0Complex() async {
    double? r = await UserInputData.getR();
    double? l = await UserInputData.getL();
    double? g = await UserInputData.getG();
    double? c = await UserInputData.getC();
    double? f = await UserInputData.getF();

    //debugPrint('r: $r, l: $l, g: $g, c: $c, f: $f');

    Complex z0 = calcZ0(r!, l!, g!, c!, f!);

    await UserInputData.saveZ0(z0);
  }

// calc phase velocity
  static Future<void> calcPhaseV() async {
    double? f = await UserInputData.getF();
    double? beta = await UserInputData.getBeta();

    double muP = calcMuP(f!, beta!);
    debugPrint('muP: $muP');

    await UserInputData.saveMuP(muP);
  }

// calc wavelength
  static Future<void> calcWavelength() async {
    double? f = await UserInputData.getF();
    double? muP = await UserInputData.getMuP();

    double lambda = calcLambda(f!, muP!);
    debugPrint('lambda: $lambda');

    await UserInputData.saveLambda(lambda);
  }

// calc bigGamma, S, zIn
  static Future<void> calcAddedTxParams() async {
    Complex? zL = await UserInputData.getZL();
    double? z0Lossless = await UserInputData.getZ0Lossless();
    double? beta = await UserInputData.getBeta();
    double? length = await UserInputData.getLength();

    Complex bigGamma = calcBigGamma(zL!, z0Lossless!);
    double S = calcS(bigGamma);
    Complex zIn = calcZIn(zL!, z0Lossless!, beta!, length!);

    await UserInputData.saveAddedTxParams(bigGamma, S, zIn);
  }

// ======================== RELEVANT FORMULAE ==========================

/*
  WEEK 3:
*/

// calc bigGamma
  static Complex calcBigGamma(Complex zL, double z0) {
    Complex term1 = Complex(zL.real - z0, zL.imaginary);
    Complex term2 = Complex(zL.real + z0, zL.imaginary);
    Complex bigGamma = term1 / term2;

    debugPrint('term1: $term1, term2: $term2, bigGamma: $bigGamma');

    return bigGamma;
  }

// calc S (vswr)
  static double calcS(Complex bigGamma) {
    double term1 = 1 + bigGamma.abs();
    double term2 = 1 - bigGamma.abs();
    double S = term1 / term2;

    debugPrint('term1: $term1, term2: $term2, s: $S');

    return S;
  }

// calc zIn
  static Complex calcZIn(
      Complex zL, double z0Lossless, double beta, double length) {
    double tanBetaL = tan(beta * length);

    // Complex term1 = Complex((zL.real * cosBetaL),
    //     (zL.imaginary * cosBetaL) + (z0Lossless * sinBetaL));
    // Complex term2 = Complex((z0Lossless * cosBetaL) - (zL.imaginary * sinBetaL),
    //     zL.real * sinBetaL);
    Complex term1 = Complex(zL.real, zL.imaginary + z0Lossless * tanBetaL);
    Complex term2 =
        Complex(z0Lossless - zL.imaginary * tanBetaL, zL.real * tanBetaL);
    Complex ratio = term1 / term2;
    Complex zIn =
        Complex(z0Lossless * ratio.real, z0Lossless * ratio.imaginary);

    debugPrint('term1: $term1, term2: $term2, zin: $zIn');

    return zIn;
  }

// for microstrip: Z0
  static double calcZ0Micro(double epsilonEff, double wMicro, double hMicro) {
    double term1 = 60 / sqrt(epsilonEff);
    double term2 = log(8 * hMicro / wMicro + wMicro / (4 * hMicro));
    double z0Micro = term1 / term2;

    debugPrint('term1: $term1, term2: $term2, z0Micro: $z0Micro');

    return z0Micro;
  }

// for microstrip: s, epsilonEff, x, y, t
  // width to thickness ratio
  static double calcSRatio(double wMicro, double hMicro) {
    return wMicro / hMicro;
  }

  // effective permittivity: epsilonEff
  static double calcEpsilonEff(
      double epsilonR, double sRatio, double x, double y) {
    double term1 = (epsilonR + 1) / 2;
    double term2 = (epsilonR - 1) / 2;
    double term3 = 1 + (10 / sRatio);
    double epsilonEff = term1 + term2 * pow(term3, -(x * y));

    debugPrint(
        'term1: $term1, term2: $term2, term3: $term3, epsilonEff: $epsilonEff');

    return epsilonEff;
  }

  // x
  static double calcX(double epsilonR) {
    double term1 = epsilonR - 0.9;
    double term2 = epsilonR + 3;
    double x = 0.56 * pow(term1 / term2, 0.05);
    return x;
  }

  // y
  static double calcY(double sRatio) {
    double term1_1 = pow(sRatio, 4) + pow(3.7, -4) * pow(sRatio, 2) as double;
    double term1_2 = pow(sRatio, 4) + 0.43;
    double term1 = log(term1_1 / term1_2);
    double term2 = log(1 + pow(1.7, -4) * pow(sRatio, 3));
    double y = 1 + 0.02 * term1 + 0.05 * term2;
    return y;
  }

  // t
  static double calcT(double sRatio) {
    double t = pow(30.67 / sRatio, 0.75) as double;
    return t;
  }

/*
  WEEK 2:
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
  static Complex calcZ0(double r, double l, double g, double c, double f) {
    double omega = 2 * pi * f;
    Complex term1 = Complex(r, omega * l); // R' + jωL'
    Complex term2 = Complex(g, omega * c); // G' + jωC'
    Complex z0 = (term1 / term2).sqrt();

    debugPrint('z0Re: ${z0.real}, term2: ${z0.imaginary}');

    return z0;
  }

// calculate phase velocity (v)
  static double calcMuP(double f, double beta) {
    double omega = 2 * pi * f;
    double muP = omega / beta;
    return muP;
  }

// calculate wavelength (lambda)
  static double calcLambda(double f, double muP) {
    double lambda = muP / f;
    return lambda;
  }

/*
  WEEK 1:
*/

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

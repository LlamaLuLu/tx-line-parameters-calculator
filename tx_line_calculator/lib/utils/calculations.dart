import 'dart:math';
import 'package:tx_line_calculator/utils/user_input_data.dart';

// MUST STILL CALCULATE GENERAL MU AND SIGMA

class Calculations {
// calculate Rs
  static double calcRs(double muC, double sigmaC, double f) {
    return sqrt((pi * f * muC) / sigmaC);
  }

// evaluate coaxial params
  static Future<void> evalCoaxial(int geometry, double a, double b) async {
    await UserInputData.saveSelectedGeometry(geometry);
    await UserInputData.saveCoaxialData(a, b);

    double muC = (await UserInputData.getMuC()) ?? 0.0;
    double sigmaC = (await UserInputData.getSigmaC()) ?? 0.0;
    double f = (await UserInputData.getF()) ?? 0.0;
    double muR = (await UserInputData.getMuR()) ?? 0.0;
    double sigma = (await UserInputData.getSigma()) ?? 0.0;
    double epsilonR = (await UserInputData.getEpsilonR()) ?? 0.0;

    double rS = calcRs(muC, sigmaC, f);
    double r = calcRCoaxial(rS, a, b);
    double l = calcLCoaxial(muR, a, b);
    double g = calcGCoaxial(sigma, a, b);
    double c = calcCCoaxial(epsilonR, a, b);

    await UserInputData.saveCoaxialResults(rS, r, l, g, c);
  }

// evaluate 2-wire params
  static Future<void> eval2Wire(int geometry, double D, double d) async {
    await UserInputData.saveSelectedGeometry(geometry);
    await UserInputData.save2WireData(D, d);

    double muC = (await UserInputData.getMuC()) ?? 0.0;
    double sigmaC = (await UserInputData.getSigmaC()) ?? 0.0;
    double f = (await UserInputData.getF()) ?? 0.0;
    double muR = (await UserInputData.getMuR()) ?? 0.0;
    double sigma = (await UserInputData.getSigma()) ?? 0.0;
    double epsilonR = (await UserInputData.getEpsilonR()) ?? 0.0;

    double rS = calcRs(muC, sigmaC, f);
    double r = calcR2Wire(rS, d);
    double l = calcL2Wire(muR, D, d);
    double g = calcG2Wire(sigma, D, d);
    double c = calcC2Wire(epsilonR, D, d);

    await UserInputData.save2WireResults(rS, r, l, g, c);
  }

// evaluate parallel plate params
  static Future<void> evalParallelPlate(
      int geometry, double w, double h) async {
    await UserInputData.saveSelectedGeometry(geometry);
    await UserInputData.saveParallelPlateData(w, h);

    double muC = (await UserInputData.getMuC()) ?? 0.0;
    double sigmaC = (await UserInputData.getSigmaC()) ?? 0.0;
    double f = (await UserInputData.getF()) ?? 0.0;
    double muR = (await UserInputData.getMuR()) ?? 0.0;
    double sigma = (await UserInputData.getSigma()) ?? 0.0;
    double epsilonR = (await UserInputData.getEpsilonR()) ?? 0.0;

    double rS = calcRs(muC, sigmaC, f);
    double r = calcRParallel(rS, w);
    double l = calcLParallel(muR, w, h);
    double g = calcGParallel(sigma, w, h);
    double c = calcCParallel(epsilonR, w, h);

    await UserInputData.saveParallelPlateResults(rS, r, l, g, c);
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
    return ratio + sqrt(pow(ratio, 2) - 1);
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

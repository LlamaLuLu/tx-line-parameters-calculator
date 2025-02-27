import 'dart:math';

// MUST DOUBLE-CHECK VALUES WITH DATASHEET

class Constants {
  static double mu0 = 4 * pi * pow(10, -7);
  static double epsilon0 = 8.854 * pow(10, -12);

  // conductors: copper, aluminum, silver, gold
  // copper
  static double sigmaCCu = 5.8 * pow(10, 7);
  static double muCCu = 1.26 * pow(10, -6);
  // aluminum
  static double sigmaCAl = 3.5 * pow(10, 7);
  static double muCAl = 1.26 * pow(10, -6);
  // silver
  static double sigmaCAg = 6.3 * pow(10, 7);
  static double muCAg = 1.26 * pow(10, -6);
  // gold
  static double sigmaCAu = 4.1 * pow(10, 7);
  static double muCAu = 1.26 * pow(10, -6);

  // insulators: teflon, air, plastic
  // teflon
  static num sigmaRTeflon = pow(10, -20);
  static double epsilonRTeflon = 2.1;
  // air
  static num sigmaRAir = pow(10, -15);
  static double epsilonRAir = 1;
  // plastic
  static num sigmaRPlastic = pow(10, -15);
  static double epsilonRPlastic = 2.5;
}

import 'dart:math';

// MUST DOUBLE-CHECK VALUES WITH DATASHEET

class Constants {
  static double mu0 = 4 * pi * pow(10, -7);
  static double mu0Default = 4 * pi * pow(10, -1);
  static double epsilon0 =
      8.854 * pow(10, -12); // relative permittivity of free space
  static double c = 3 * pow(10, 8).toDouble(); // speed of light in vacuum

  // CONDUCTORS:
  // copper
  static double sigmaCCu = 5.8 * pow(10, 7);
  // aluminum
  static double sigmaCAl = 3.5 * pow(10, 7);
  // silver
  static double sigmaCAg = 6.2 * pow(10, 7);
  // gold
  static double sigmaCAu = 4.1 * pow(10, 7);

  // INSULATORS:
  // polystyrene
  static double sigmaRPolystyrene = 0.0;
  static double epsilonRPolystyrene = 2.6;
  // air
  static double sigmaRAir = pow(10, -15).toDouble();
  static double epsilonRAir = 1;
  // teflon
  static double sigmaRTeflon = pow(10, -20).toDouble();
  static double epsilonRTeflon = 2.1;
  // polyethylene
  static double sigmaRPolyethylene = pow(10, -15).toDouble();
  static double epsilonRPolyethylene = 2.25;
  // plastic
  static double sigmaRPlastic = pow(10, -15).toDouble();
  static double epsilonRPlastic = 2.5;
}

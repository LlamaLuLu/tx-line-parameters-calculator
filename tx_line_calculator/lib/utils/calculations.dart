import 'dart:math';

class Calculations {
// calculate Rs
  double calcRs(double uc, double oc, double f) {
    return sqrt((pi * f * uc) / oc);
  }

// calculate R'
  double calcRCoaxial(double rs, double a, double b) {
    return (rs / (2 * pi)) * ((1 / a) + (1 / b));
  }

  double calcR2Wire(double rs, double d) {
    return (2 * rs) / (pi * d);
  }

  double calcRParallel(double rs, double w) {
    return (2 * rs) / w;
  }

// calculate L'
  double calcLCoaxial(double u, double a, double b) {
    return (u / (2 * pi)) * log(b / a);
  }

  double calcL2Wire(double u, double D, double d) {
    double ratio = D / d;
    return ratio + sqrt(pow(ratio, 2) - 1);
  }

  double calcLParallel(double u, double w, double h) {
    return (u * h) / w;
  }

// calculate G'
  double calcGCoaxial(double o, double a, double b) {
    return (2 * pi * o) / log(b / a);
  }

  double calcG2Wire(double o, double D, double d) {
    double ratio = D / d;
    return (pi * o) / log(ratio + sqrt(pow(ratio, 2) - 1));
  }

  double calcGParallel(double o, double w, double h) {
    return (o * w) / h;
  }

// calculate C'
  double calcCCoaxial(double e, double a, double b) {
    return (2 * pi * e) / log(b / a);
  }

  double calcC2Wire(double e, double D, double d) {
    double ratio = D / d;
    return (pi * e) / log(ratio + sqrt(pow(ratio, 2) - 1));
  }

  double calcCParallel(double e, double w, double h) {
    return (e * w) / h;
  }
}

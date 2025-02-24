import 'dart:math';

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

double calcLParallel(double u, double h, double w) {
  return (u * h) / w;
}

// calculate G'
double calcGCoaxial(double uc, double oc, double f) {
  return (2 * pi * f * oc) / uc;
}

double calcG2Wire(double uc, double oc, double f) {
  return (2 * pi * f * oc) / uc;
}

double calcGParallel(double uc, double oc, double f) {
  return (2 * pi * f * oc) / uc;
}

// calculate C'
double calcCCoaxial(double uc, double oc, double f) {
  return (2 * pi * f * uc) / oc;
}

double calcC2Wire(double uc, double oc, double f) {
  return (2 * pi * f * uc) / oc;
}

double calcCParallel(double uc, double oc, double f) {
  return (2 * pi * f * uc) / oc;
}

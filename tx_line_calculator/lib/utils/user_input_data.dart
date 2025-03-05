import 'dart:math';

import 'package:complex/complex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInputData {
  /*
    VARIABLES:
  */

  // conductor data
  static const String muCKey = 'muC';
  static const String sigmaCKey = 'sigmaC';
  // insulator data
  static const String muRKey = 'muR';
  static const String epsilonRKey = 'epsilonR';
  static const String sigmaKey = 'sigma';
  // frequency
  static const String fKey = 'f';

  static const String selectedGeometryKey = 'selectedGeometry';

  // coaxial data
  static const String aKey = 'a';
  static const String bKey = 'b';
  // 2-wire data
  static const String DKey = 'D';
  static const String dKey = 'd';
  // parallel plate data
  static const String wKey = 'w';
  static const String hKey = 'h';

  // calculated results:
  static const String rSKey = 'rS';

  // coaxial
  static const String rCoaxialKey = 'rCoaxial';
  static const String lCoaxialKey = 'lCoaxial';
  static const String gCoaxialKey = 'gCoaxial';
  static const String cCoaxialKey = 'cCoaxial';
  // 2-wire
  static const String r2WireKey = 'r2Wire';
  static const String l2WireKey = 'l2Wire';
  static const String g2WireKey = 'g2Wire';
  static const String c2WireKey = 'c2Wire';
  // parallel plate
  static const String rParallelKey = 'rParallel';
  static const String lParallelKey = 'lParallel';
  static const String gParallelKey = 'gParallel';
  static const String cParallelKey = 'cParallel';

  // complex propagation constant
  static const String gammaKey = 'propConst';
  static const String alphaKey = 'attenConst';
  static const String betaKey = 'phaseConst';

  // characteristic impedance

  // phase velocity

  // wavelength

  /*
    FUNCTIONS:
  */

  // complex propagation constant
  static Future<void> saveGamma(Complex gamma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(alphaKey, gamma.real);
    await prefs.setDouble(betaKey, gamma.imaginary);
  }

  // attenuation constant

  // phase constant

  // geometry
  static Future<void> saveSelectedGeometry(int geometry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedGeometryKey, geometry);
  }

  static Future<int?> getSelectedGeometry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(selectedGeometryKey);
  }

  // save conductor data
  static Future<void> saveConductorData(double muC, double sigmaC) async {
    await saveMuC(muC);
    await saveSigmaC(sigmaC);
  }

  // save insulator data
  static Future<void> saveInsulatorData(
      double muR, double epsilonR, double sigma) async {
    await saveMuR(muR);
    await saveEpsilonR(epsilonR);
    await saveSigma(sigma);
  }

  // save coaxial data
  static Future<void> saveCoaxialData(double a, double b) async {
    await saveA(a);
    await saveB(b);
  }

  // save coaxial results
  static Future<void> saveCoaxialResults(
      double rS, double r, double l, double g, double c) async {
    await saveRS(rS);
    await saveRCoaxial(r);
    await saveLCoaxial(l);
    await saveGCoaxial(g);
    await saveCCoaxial(c);
  }

  // save 2-wire data
  static Future<void> save2WireData(double D, double d) async {
    await saveD(D);
    await saveDiameter(d);
  }

  // save 2-wire results
  static Future<void> save2WireResults(
      double rS, double r, double l, double g, double c) async {
    await saveRS(rS);
    await saveR2Wire(r);
    await saveL2Wire(l);
    await saveG2Wire(g);
    await saveC2Wire(c);
  }

  // save parallel plate data
  static Future<void> saveParallelPlateData(double w, double h) async {
    await saveW(w);
    await saveH(h);
  }

  // save parallel plate results
  static Future<void> saveParallelPlateResults(
      double rS, double r, double l, double g, double c) async {
    await saveRS(rS);
    await saveRParallel(r);
    await saveLParallel(l);
    await saveGParallel(g);
    await saveCParallel(c);
  }

  // muC
  static Future<void> saveMuC(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(muCKey, value);
  }

  static Future<double?> getMuC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(muCKey) ??
        (4 * pi * 1e-7); // Permeability of free space
  }

  // sigmaC
  static Future<void> saveSigmaC(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(sigmaCKey, value);
  }

  static Future<double?> getSigmaC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(sigmaCKey) ?? 4e7; // Conductivity of copper
  }

  // muR
  static Future<void> saveMuR(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(muRKey, value);
  }

  static Future<double?> getMuR() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(muRKey) ?? 1.0; // Relative permeability (vacuum)
  }

  // epsilonR
  static Future<void> saveEpsilonR(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(epsilonRKey, value);
  }

  static Future<double?> getEpsilonR() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(epsilonRKey) ??
        1.0; // Relative permittivity (vacuum)
  }

  // sigma
  static Future<void> saveSigma(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(sigmaKey, value);
  }

  static Future<double?> getSigma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(sigmaKey) ??
        4e-5; // Conductivity for air or default material
  }

  // frequency
  static Future<void> saveF(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(fKey, value);
  }

  static Future<double?> getF() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(fKey) ?? 2e9; // Default frequency (2 GHz)
  }

  // a
  static Future<void> saveA(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(aKey, value);
  }

  static Future<double?> getA() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(aKey) ?? 0.0;
  }

  // b
  static Future<void> saveB(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(bKey, value);
  }

  static Future<double?> getB() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(bKey) ?? 0.0;
  }

  // D
  static Future<void> saveD(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(DKey, value);
  }

  static Future<double?> getD() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(DKey) ?? 0.0;
  }

  // d
  static Future<void> saveDiameter(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(dKey, value);
  }

  static Future<double?> getDiameter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(dKey) ?? 0.0;
  }

  // w
  static Future<void> saveW(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(wKey, value);
  }

  static Future<double?> getW() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(wKey) ?? 0.0;
  }

  // h
  static Future<void> saveH(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(hKey, value);
  }

  static Future<double?> getH() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(hKey) ?? 0.0;
  }

  // rS,r,l,g,c
  static Future<void> saveRS(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(rSKey, value);
  }

  static Future<double?> getRS() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(rSKey);
  }

  static Future<double?> getR() async {
    final prefs = await SharedPreferences.getInstance();
    int? geometry = await getSelectedGeometry();

    switch (geometry) {
      case 1: // Coaxial
        return prefs.getDouble(rCoaxialKey);
      case 2: // 2-Wire
        return prefs.getDouble(r2WireKey);
      case 3: // Parallel Plate
        return prefs.getDouble(rParallelKey);
      default:
        return null;
    }
  }

  static Future<double?> getL() async {
    final prefs = await SharedPreferences.getInstance();
    int? geometry = await getSelectedGeometry();

    switch (geometry) {
      case 1: // Coaxial
        return prefs.getDouble(lCoaxialKey);
      case 2: // 2-Wire
        return prefs.getDouble(l2WireKey);
      case 3: // Parallel Plate
        return prefs.getDouble(lParallelKey);
      default:
        return null;
    }
  }

  static Future<double?> getG() async {
    final prefs = await SharedPreferences.getInstance();
    int? geometry = await getSelectedGeometry();

    switch (geometry) {
      case 1: // Coaxial
        return prefs.getDouble(gCoaxialKey);
      case 2: // 2-Wire
        return prefs.getDouble(g2WireKey);
      case 3: // Parallel Plate
        return prefs.getDouble(gParallelKey);
      default:
        return null;
    }
  }

  static Future<double?> getC() async {
    final prefs = await SharedPreferences.getInstance();
    int? geometry = await getSelectedGeometry();

    switch (geometry) {
      case 1: // Coaxial
        return prefs.getDouble(cCoaxialKey);
      case 2: // 2-Wire
        return prefs.getDouble(c2WireKey);
      case 3: // Parallel Plate
        return prefs.getDouble(cParallelKey);
      default:
        return null;
    }
  }

  // rCoaxial
  static Future<void> saveRCoaxial(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(rCoaxialKey, value);
  }

  static Future<double?> getRCoaxial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(rCoaxialKey) ?? 0.0;
  }

  // lCoaxial
  static Future<void> saveLCoaxial(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(lCoaxialKey, value);
  }

  static Future<double?> getLCoaxial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(lCoaxialKey) ?? 0.0;
  }

  // gCoaxial
  static Future<void> saveGCoaxial(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(gCoaxialKey, value);
  }

  static Future<double?> getGCoaxial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(gCoaxialKey) ?? 0.0;
  }

  // cCoaxial
  static Future<void> saveCCoaxial(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(cCoaxialKey, value);
  }

  static Future<double?> getCCoaxial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(cCoaxialKey) ?? 0.0;
  }

  // r2Wire
  static Future<void> saveR2Wire(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(r2WireKey, value);
  }

  static Future<double?> getR2Wire() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(r2WireKey) ?? 0.0;
  }

  // l2Wire
  static Future<void> saveL2Wire(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(l2WireKey, value);
  }

  static Future<double?> getL2Wire() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(l2WireKey) ?? 0.0;
  }

  // g2Wire
  static Future<void> saveG2Wire(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(g2WireKey, value);
  }

  static Future<double?> getG2Wire() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(g2WireKey) ?? 0.0;
  }

  // c2Wire
  static Future<void> saveC2Wire(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(c2WireKey, value);
  }

  static Future<double?> getC2Wire() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(c2WireKey) ?? 0.0;
  }

  // rParallel
  static Future<void> saveRParallel(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(rParallelKey, value);
  }

  static Future<double?> getRParallel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(rParallelKey) ?? 0.0;
  }

  // lParallel
  static Future<void> saveLParallel(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(lParallelKey, value);
  }

  static Future<double?> getLParallel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(lParallelKey) ?? 0.0;
  }

  // gParallel
  static Future<void> saveGParallel(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(gParallelKey, value);
  }

  static Future<double?> getGParallel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(gParallelKey) ?? 0.0;
  }

  // cParallel
  static Future<void> saveCParallel(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(cParallelKey, value);
  }

  static Future<double?> getCParallel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(cParallelKey) ?? 0.0;
  }
}

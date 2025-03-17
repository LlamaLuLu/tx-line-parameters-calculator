import 'dart:math';

import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tx_line_calculator/utils/constants.dart';

class UserInputData {
  // ============================ VARIABLES ============================

  /*
    USER INPUTS:
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

  // line geometry
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
  // microstrip data
  static const String wMicrostripKey = 'wMicrostrip';
  static const String hMicrostripKey = 'hMicrostrip';

  // characteristic impedance (lossless)
  static const String z0LosslessKey = 'z0Lossless';
  // load impedance
  static const String zLReKey = 'zLRe';
  static const String zLImKey = 'zLIm';
  // wire length
  static const String lengthKey = 'length';

  /*
    CALCULATED RESULTS:
  */

  // Rs
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
  // microstrip
  static const String rMicrostripKey = 'rMicrostrip';
  static const String lMicrostripKey = 'lMicrostrip';
  static const String gMicrostripKey = 'gMicrostrip';
  static const String cMicrostripKey = 'cMicrostrip';
  static const String sRatioKey = 'sRatio';

  // complex propagation constant
  static const String alphaKey = 'attenConst';
  static const String betaKey = 'phaseConst';
  // characteristic impedance
  static const String z0ReKey = 'z0Re';
  static const String z0ImKey = 'z0Im';
  // phase velocity
  static const String muPKey = 'phaseV';
  // wavelength
  static const String lambdaKey = 'wavelength';

  // reflection coefficient
  static const String bigGammaReKey = 'reflecCoeffRe';
  static const String bigGammaImKey = 'reflecCoeffIm';
  // voltage standing wave ratio
  static const String SKey = 'sKey';
  // wave impedance
  static const String zInReKey = 'zInRe';
  static const String zInImKey = 'zInIm';

  // ========================== FUNCTIONS ==========================

  // clear all user inputs
  static Future<void> clearAllData() async {
    await clearMaterialsData();
    await clearLosslessData();

    debugPrint('All user inputs cleared');
  }

  // clear user inputs: materials
  static Future<void> clearMaterialsData() async {
    await saveConductorData(Constants.mu0, double.infinity);
    await saveInsulatorData(Constants.mu0, 1.0, 0.0);
    await saveF(2e9);
    await saveSelectedGeometry(1);
    await saveCoaxialData(0.0, 0.0);
    await save2WireData(0.0, 0.0);
    await saveParallelPlateData(0.0, 0.0);
    await saveMicrostripData(0.0, 0.0);

    debugPrint('User inputs cleared for Materials');
  }

  // clear user inputs: lossless
  static Future<void> clearLosslessData() async {
    await saveZ0Lossless(0.0);
    await saveZL(Complex(0.0, 0.0));
    await saveLength(0.0);

    debugPrint('User inputs cleared for Lossless Line');
  }

  /*
    WEEK 3:
  */

  // save bigGamma, S, zIn
  static Future<void> saveAddedTxParams(
      Complex bigGamma, double S, Complex zIn) async {
    await saveBigGamma(bigGamma);
    await saveS(S);
    await saveZIn(zIn);
  }

  // reflection coeff: big gamma
  static Future<void> saveBigGamma(Complex bigGamma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(bigGammaReKey, bigGamma.real);
    await prefs.setDouble(bigGammaImKey, bigGamma.imaginary);
  }

  static Future<Complex?> getBigGamma() async {
    final prefs = await SharedPreferences.getInstance();
    double? real = prefs.getDouble(bigGammaReKey);
    double? imag = prefs.getDouble(bigGammaImKey);

    if (real != null && imag != null) {
      return Complex(real, imag);
    }
    return null;
  }

  // voltage standing wave ratio: S
  static Future<void> saveS(double S) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(SKey, S);
  }

  static Future<double?> getS() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(SKey);
  }

  // wave impedance: zIn
  static Future<void> saveZIn(Complex zIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(zInReKey, zIn.real);
    await prefs.setDouble(zInImKey, zIn.imaginary);
  }

  static Future<Complex?> getZIn() async {
    final prefs = await SharedPreferences.getInstance();
    double? real = prefs.getDouble(zInReKey);
    double? imag = prefs.getDouble(zInImKey);

    if (real != null && imag != null) {
      return Complex(real, imag);
    }
    return null;
  }

  // characteristic impedance (lossless): z0
  static Future<void> saveZ0Lossless(double z0) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(z0LosslessKey, z0);
  }

  static Future<double?> getZ0Lossless() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(z0LosslessKey);
  }

  // load impedance: zL
  static Future<void> saveZL(Complex zL) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(zLReKey, zL.real);
    await prefs.setDouble(zLImKey, zL.imaginary);
  }

  static Future<Complex?> getZL() async {
    final prefs = await SharedPreferences.getInstance();
    double? real = prefs.getDouble(zLReKey);
    double? imag = prefs.getDouble(zLImKey);

    if (real != null && imag != null) {
      return Complex(real, imag);
    }
    return null;
  }

  // wire length: l
  static Future<void> saveLength(double l) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(lengthKey, l);
  }

  static Future<double?> getLength() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(lengthKey);
  }

  /*
    WEEK 2:
  */

  // save complex propagation constants: gamma, alpha, beta
  static Future<void> savePropConstants(double alpha, double beta) async {
    await saveAlpha(alpha);
    await saveBeta(beta);
  }

  // attenuation constant: alpha
  static Future<void> saveAlpha(double alpha) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(alphaKey, alpha);
  }

  static Future<double?> getAlpha() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(alphaKey);
  }

  // phase constant: beta
  static Future<void> saveBeta(double beta) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(betaKey, beta);
  }

  static Future<double?> getBeta() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(betaKey);
  }

  // characteristic impedance: z0
  static Future<void> saveZ0(Complex z0) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(z0ReKey, z0.real);
    await prefs.setDouble(z0ImKey, z0.imaginary);
  }

  static Future<Complex?> getZ0() async {
    final prefs = await SharedPreferences.getInstance();
    double? real = prefs.getDouble(z0ReKey);
    double? imag = prefs.getDouble(z0ImKey);

    if (real != null && imag != null) {
      return Complex(real, imag);
    }
    return null;
  }

  // phase velocity: muP
  static Future<void> saveMuP(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(muPKey, value);
  }

  static Future<double?> getMuP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(muPKey);
  }

  // wavelength: lambda
  static Future<void> saveLambda(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(lambdaKey, value);
  }

  static Future<double?> getLambda() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(lambdaKey);
  }

  /*
    WEEK 1:
  */

  // geometry: coaxial, 2-wire, parallel plate, microstrip
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

  // save lossless line data
  static Future<void> saveLosslessLineData(
      double z0Lossless, double zLRe, double zLIm, double l) async {
    await saveZ0Lossless(z0Lossless);
    await saveZL(Complex(zLRe, zLIm));
    await saveLength(l);
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

  // save microstrip data
  static Future<void> saveMicrostripData(double w, double h) async {
    await saveWMicrostrip(w);
    await saveHMicrostrip(h);
  }

  // save microstrip results
  static Future<void> saveMicrostripResults(
      double r, double l, double g, double c, double sRatio) async {
    await saveRMicrostrip(r);
    await saveLMicrostrip(l);
    await saveGMicrostrip(g);
    await saveCMicrostrip(c);
    await saveSRatio(sRatio);
  }

  // muC
  static Future<void> saveMuC(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(muCKey, value);
  }

  static Future<double?> getMuC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(muCKey);
  }

  // sigmaC
  static Future<void> saveSigmaC(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(sigmaCKey, value);
  }

  static Future<double?> getSigmaC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(sigmaCKey);
  }

  // muR
  static Future<void> saveMuR(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(muRKey, value);
  }

  static Future<double?> getMuR() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(muRKey);
  }

  // epsilonR
  static Future<void> saveEpsilonR(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(epsilonRKey, value);
  }

  static Future<double?> getEpsilonR() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(epsilonRKey);
  }

  // sigma
  static Future<void> saveSigma(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(sigmaKey, value);
  }

  static Future<double?> getSigma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(sigmaKey);
  }

  // frequency
  static Future<void> saveF(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(fKey, value);
  }

  static Future<double?> getF() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(fKey);
  }

  // a
  static Future<void> saveA(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(aKey, value);
  }

  static Future<double?> getA() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(aKey);
  }

  // b
  static Future<void> saveB(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(bKey, value);
  }

  static Future<double?> getB() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(bKey);
  }

  // D
  static Future<void> saveD(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(DKey, value);
  }

  static Future<double?> getD() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(DKey);
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

  // w microstrip
  static Future<void> saveWMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(wMicrostripKey, value);
  }

  static Future<double?> getWMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(wMicrostripKey);
  }

  // h microstrip
  static Future<void> saveHMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(hMicrostripKey, value);
  }

  static Future<double?> getHMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(hMicrostripKey);
  }

  // sRatio
  static Future<void> saveSRatio(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(sRatioKey, value);
  }

  static Future<double?> getSRatio() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(sRatioKey);
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
      case 4: // Microstrip
        return prefs.getDouble(rMicrostripKey);
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
      case 4: // Microstrip
        return prefs.getDouble(lMicrostripKey);
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
      case 4: // Microstrip
        return prefs.getDouble(gMicrostripKey);
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
      case 4: // Microstrip
        return prefs.getDouble(cMicrostripKey);
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

  // rMicrostrip
  static Future<void> saveRMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(rMicrostripKey, value);
  }

  static Future<double?> getRMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(rMicrostripKey) ?? 0.0;
  }

  // lMicrostrip
  static Future<void> saveLMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(lMicrostripKey, value);
  }

  static Future<double?> getLMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(lMicrostripKey) ?? 0.0;
  }

  // gMicrostrip
  static Future<void> saveGMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(gMicrostripKey, value);
  }

  static Future<double?> getGMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(gMicrostripKey) ?? 0.0;
  }

  // cMicrostrip
  static Future<void> saveCMicrostrip(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(cMicrostripKey, value);
  }

  static Future<double?> getCMicrostrip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(cMicrostripKey) ?? 0.0;
  }
}

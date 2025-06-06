import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/calculations.dart';
import 'package:tx_line_calculator/utils/constants.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class AppWidgets extends StatelessWidget {
  const AppWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // BUTTONS:

  static Widget nextBtnConductor(
      BuildContext context,
      String route,
      TextEditingController muCController,
      TextEditingController sigmaCController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 45), // Adjust spacing
        child: ElevatedButton(
          onPressed: () async {
            // parse values when button is pressed
            double muC = (double.tryParse(muCController.text.trim())) ??
                Constants.mu0Default;
            muC *= pow(10, -6);
            double sigmaC = double.tryParse(sigmaCController.text.trim()) ??
                double.infinity;
            sigmaC *= pow(10, 7);

            debugPrint("muC: $muC, sigmaC: $sigmaC");

            await UserInputData.saveConductorData(muC, sigmaC);
            Navigator.pushNamed(
                context, route); // Replace with your actual route
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Use your theme color
            foregroundColor: AppColours.background, // White text for contrast
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4, // Slight shadow for depth
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Next'), // Button text
              SizedBox(width: 8), // Space between text and icon
              Icon(
                Icons.arrow_forward,
                size: 22,
                color: AppColours.background,
              ), // Arrow icon
            ],
          ),
        ),
      ),
    );
  }

  static Widget nextBtnInsulator(
      BuildContext context,
      String route,
      TextEditingController muRController,
      TextEditingController epsilonRController,
      TextEditingController sigmaController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55, right: 45), // Adjust spacing
        child: ElevatedButton(
          onPressed: () async {
            // parse values when button is pressed
            double muR = double.tryParse(muRController.text.trim()) ??
                Constants.mu0Default;
            muR *= pow(10, -6);
            double epsilonR =
                double.tryParse(epsilonRController.text.trim()) ?? 1.0;
            double sigma = double.tryParse(sigmaController.text.trim()) ?? 0.0;
            sigma *= pow(10, -6);

            debugPrint("muR: $muR, epsilonR: $epsilonR, sigma: $sigma");

            await UserInputData.saveInsulatorData(muR, epsilonR, sigma);
            Navigator.pushNamed(
                context, route); // Replace with your actual route
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Use your theme color
            foregroundColor: AppColours.background, // White text for contrast
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4, // Slight shadow for depth
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Next'), // Button text
              SizedBox(width: 8), // Space between text and icon
              Icon(
                Icons.arrow_forward,
                size: 22,
                color: AppColours.background,
              ), // Arrow icon
            ],
          ),
        ),
      ),
    );
  }

  static Widget nextBtnFrequency(
      BuildContext context, String route, TextEditingController fController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55, right: 45),
        child: ElevatedButton(
          onPressed: () async {
            // parse values when button is pressed
            double f = double.tryParse(fController.text.trim()) ?? 0.0;
            f *= pow(10, 9);

            debugPrint("frequency: $f");

            await UserInputData.saveF(f);
            Navigator.pushNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary,
            foregroundColor: AppColours.background,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4, // Slight shadow for depth
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Next'), // Button text
              SizedBox(width: 8), // Space between text and icon
              Icon(
                Icons.arrow_forward,
                size: 22,
                color: AppColours.background,
              ), // Arrow icon
            ],
          ),
        ),
      ),
    );
  }

  static Widget materialPresetBtn(BuildContext context, String material,
      Color txtColor, Color bgColor, String route) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust spacing
        child: ElevatedButton(
          onPressed: () async {
            // conductor presets
            if (material == "Copper") {
              await UserInputData.saveConductorData(
                  Constants.mu0, Constants.sigmaCCu);
            } else if (material == "Aluminium") {
              await UserInputData.saveConductorData(
                  Constants.mu0, Constants.sigmaCAl);
            } else if (material == "Gold") {
              await UserInputData.saveConductorData(
                  Constants.mu0, Constants.sigmaCAu);
            } else if (material == "Silver") {
              await UserInputData.saveConductorData(
                  Constants.mu0, Constants.sigmaCAg);
            }
            // insulator presets
            else if (material == "Polystyrene") {
              await UserInputData.saveInsulatorData(Constants.mu0,
                  Constants.epsilonRPolystyrene, Constants.sigmaRPolystyrene);
            } else if (material == "Air") {
              await UserInputData.saveInsulatorData(
                  Constants.mu0, Constants.epsilonRAir, Constants.sigmaRAir);
            } else if (material == "Teflon") {
              await UserInputData.saveInsulatorData(Constants.mu0,
                  Constants.epsilonRTeflon, Constants.sigmaRTeflon);
            } else if (material == "Polyethylene") {
              await UserInputData.saveInsulatorData(Constants.mu0,
                  Constants.epsilonRPolyethylene, Constants.sigmaRPolyethylene);
            } else if (material == "Plastic") {
              await UserInputData.saveInsulatorData(Constants.mu0,
                  Constants.epsilonRPlastic, Constants.sigmaRPlastic);
            }

            Navigator.pushNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor, // Background color
            foregroundColor: txtColor, // Text color
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4,
            padding: const EdgeInsets.symmetric(vertical: 35), // Same height
          ),
          child: Text(material),
        ),
      ),
    );
  }

  static Widget evaluateBtn(
      BuildContext context,
      int geometry,
      TextEditingController param1Controller,
      TextEditingController param2Controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: ElevatedButton(
          onPressed: () async {
            double param1 =
                double.tryParse(param1Controller.text.trim()) ?? 0.0;
            param1 *= pow(10, -3);
            double param2 =
                double.tryParse(param2Controller.text.trim()) ?? 0.0;
            param2 *= pow(10, -3);

            debugPrint("param1: $param1, param2: $param2");

            await UserInputData.saveSelectedGeometry(geometry);
            // depends on geometry:
            if (geometry == 4) {
              // lossless
              // microstrip
              await UserInputData.saveMicrostripData(param1, param2);
              Calculations.evalMicrostrip(4, param1, param2);
              // load microstrip results
              // prop constants calculated & z0 lossless saved
            } else {
              // not lossless
              if (geometry == 1) {
                // coaxial
                await UserInputData.saveCoaxialData(param1, param2);
                Calculations.evalCoaxial(1, param1, param2);
                // load coaxial results
              } else if (geometry == 2) {
                // 2-wire
                await UserInputData.save2WireData(param1, param2);
                Calculations.eval2Wire(2, param1, param2);
                // load 2-wire results
              } else if (geometry == 3) {
                // parallel plate
                await UserInputData.saveParallelPlateData(param1, param2);
                Calculations.evalParallelPlate(3, param1, param2);
                // load parallel plate results
              }

              await Calculations.calcPropConstants();
              await Calculations.calcZ0Complex();
            }

            await Calculations.calcPhaseV();
            await Calculations.calcWavelength();
            Navigator.pushNamed(context, '/results');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Background color
            padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 16), // Padding
            foregroundColor: AppColours
                .background, // Text color (use foregroundColor for text color)
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4,
          ),
          child: Text('Evaluate'),
        ),
      ),
    );
  }

  static Widget evalLosslessBtn(
      BuildContext context,
      String route,
      TextEditingController lambdaController,
      TextEditingController z0Controller,
      TextEditingController zlReController,
      TextEditingController zlImController,
      TextEditingController lController,
      TextEditingController fractionalController) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30), // Adjust spacing
        child: ElevatedButton(
          onPressed: () async {
            // parse values when button is pressed
            double? lambda = await UserInputData.getLambda();
            double newLambda =
                double.tryParse(lambdaController.text.trim()) ?? lambda ?? 0.0;
            double? z0Lossless = await UserInputData.getZ0Lossless();
            double z0 =
                double.tryParse(z0Controller.text.trim()) ?? z0Lossless ?? 0.0;
            double zLRe = double.tryParse(zlReController.text.trim()) ?? 0.0;
            double zLIm = double.tryParse(zlImController.text.trim()) ?? 0.0;
            double l;
            if (lController.text.trim().isEmpty &&
                fractionalController.text.trim().isEmpty) {
              l = 0.0;
            } else if (lController.text.trim().isEmpty) {
              double fractional =
                  double.tryParse(fractionalController.text.trim()) ?? 0.0;
              l = fractional * lambda!;
            } else {
              l = double.tryParse(lController.text.trim()) ?? 0.0;
            }

            debugPrint("z0: $z0, zLRe: $zLRe, zLIm: $zLIm, l: $l");

            await UserInputData.saveLosslessLineData(
                newLambda, z0, zLRe, zLIm, l);
            await Calculations.calcAddedTxParams();
            await Calculations.calcShortAndOpen();
            Navigator.pushNamed(
                context, route); // Replace with your actual route
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Use your theme color
            foregroundColor: AppColours.background, // White text for contrast
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4, // Slight shadow for depth
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Evaluate'),
            ],
          ),
        ),
      ),
    );
  }

  static Widget regenBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await UserInputData.clearMaterialsData();
        // save data to history page
        Navigator.pushNamed(context, '/conductors');
      },
      child: Text('Regenerate'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primary, // Background color
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding
        foregroundColor: AppColours
            .background, // Text color (use foregroundColor for text color)
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        ),
        elevation: 4,
      ),
    );
  }

  static Widget regenLosslessBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await UserInputData.clearLosslessData();
        // save data to history page
        Navigator.pushNamed(context, '/lossless_inputs');
      },
      child: Text('Regenerate'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primary, // Background color
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding
        foregroundColor: AppColours
            .background, // Text color (use foregroundColor for text color)
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        ),
        elevation: 4,
      ),
    );
  }

  static Widget newLineBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await UserInputData.clearAllData();
        // save data to history page
        Navigator.pushNamed(context, '/conductors');
      },
      child: Text('New Line'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primary, // Background color
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding
        foregroundColor: AppColours
            .background, // Text color (use foregroundColor for text color)
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        ),
        elevation: 4,
      ),
    );
  }

  static Widget continueBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // move to lossless inputs page
        Navigator.pushNamed(context, '/lossless_inputs');
      },
      child: Text('Lossless Line'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primary, // Background color
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding
        foregroundColor: AppColours
            .background, // Text color (use foregroundColor for text color)
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        ),
        elevation: 4,
      ),
    );
  }

  static Widget geometryOptBtn(BuildContext context, String route, String label,
      Color foregroundColor, Color backgroundColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 45), // Adjust spacing
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, route); // Navigate to parallel plate page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor, // Background color
              foregroundColor: foregroundColor, // Text color
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // Smooth rounded corners
              ),
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 20), // Same height
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }

  static Widget backBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20), // Adjust padding for spacing
        child: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus(); // dismiss keyboard
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 30, color: AppColours.primary),
        ),
      ),
    );
  }

  static Widget historyBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 12),
        child: SizedBox(
          width: 45,
          height: 45,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
            backgroundColor: AppColours.secondary, // Change to fit your theme
            elevation: 4,
            shape: const CircleBorder(),
            child: Icon(
              Icons.history,
              color: AppColours.ivory, // Change to fit your theme
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  static Widget startBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/conductors');
          },
          child: Text('Start'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Background color
            padding: const EdgeInsets.symmetric(
                horizontal: 36, vertical: 18), // Padding
            foregroundColor: AppColours
                .background, // Text color (use foregroundColor for text color)
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }

  // TITLE HEADINGS:

  static Widget materialsTitle(
      BuildContext context, String title, String heading) {
    return Column(children: [
      // back button
      AppWidgets.backBtn(context),

      const SizedBox(height: 25),

      // title: choose your materials:
      Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColours.backgroundOpp)),

      SizedBox(height: 30),

      // heading:
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text(heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColours.darkAccent)),
        ),
      ),

      const SizedBox(height: 15),
    ]);
  }

  static Widget anyTitle(BuildContext context, String heading) {
    return Column(children: [
      // back button
      AppWidgets.backBtn(context),

      const SizedBox(height: 25),

      // title
      Text(heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColours.backgroundOpp)),

      SizedBox(height: 20),
    ]);
  }

  static Widget withHistoryTitle(BuildContext context, String heading) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back btn
          AppWidgets.backBtn(context),

          // history btn
          AppWidgets.historyBtn(context),
        ],
      ),

      const SizedBox(height: 5),

      // title
      Text(heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColours.backgroundOpp)),

      SizedBox(height: 20),
    ]);
  }

  // WIDGET COMPONENTS:

  static Widget dividerTop() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
      child: Expanded(
        child: Divider(
          color: AppColours.darkAccent, // Line color
          thickness: 1, // Line thickness
        ),
      ),
    );
  }

  static Widget dividerBottom() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
      child: Expanded(
        child: Divider(
          color: AppColours.darkAccent, // Line color
          thickness: 1, // Line thickness
        ),
      ),
    );
  }

  static Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColours.darkAccent, // Line color
              thickness: 1, // Line thickness
              endIndent: 15, // Space between line and text
            ),
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColours.darkAccent,
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColours.darkAccent, // Line color
              thickness: 1, // Line thickness
              indent: 15, // Space between line and text
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/calculations.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class AppWidgets extends StatelessWidget {
  const AppWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // BUTTONS:

  static Widget evaluateBtn(
      BuildContext context,
      int geometry,
      TextEditingController param1Controller,
      TextEditingController param2Controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ElevatedButton(
          onPressed: () {
            double param1 =
                double.tryParse(param1Controller.text.trim()) ?? 0.0;
            double param2 =
                double.tryParse(param2Controller.text.trim()) ?? 0.0;
            // depends on geometry:
            if (geometry == 1) {
              // coaxial
              Calculations.evalCoaxial(1, param1, param2);
              // load coaxial results
            } else if (geometry == 2) {
              // 2-wire
              Calculations.eval2Wire(2, param1, param2);
              // load 2-wire results
            } else if (geometry == 3) {
              // parallel plate
              Calculations.evalParallelPlate(3, param1, param2);
              // load parallel plate results
            }

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

  static Widget regenBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ElevatedButton(
          onPressed: () {
            // do relevant calculations
            // save results

            Navigator.pushNamed(context, '/conductors');
          },
          child: Text('Regenerate'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary, // Background color
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 16), // Padding
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
        ),
      ),
    );
  }

  static Widget geometryOptBtn(BuildContext context, String route, String label,
      Color foregroundColor, Color backgroundColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 40), // Adjust spacing
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
                    BorderRadius.circular(12), // Smooth rounded corners
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

  static Widget nextBtnConductor(
      BuildContext context,
      String route,
      TextEditingController muCController,
      TextEditingController sigmaCController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55, right: 45), // Adjust spacing
        child: ElevatedButton(
          onPressed: () async {
            // parse values when button is pressed
            double muC = double.tryParse(muCController.text.trim()) ?? 0.0;
            double sigmaC =
                double.tryParse(sigmaCController.text.trim()) ?? 0.0;

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
            double muR = double.tryParse(muRController.text.trim()) ?? 0.0;
            double epsilonR =
                double.tryParse(epsilonRController.text.trim()) ?? 0.0;
            double sigma = double.tryParse(sigmaController.text.trim()) ?? 0.0;

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

  static Widget materialsTitle(BuildContext context, String heading) {
    return Column(children: [
      // back button
      AppWidgets.backBtn(context),

      const SizedBox(height: 30),

      // title: choose your materials:
      Text('Choose your materials:',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColours.backgroundOpp)),

      SizedBox(height: 30),

      // heading: conductor/insulator/frequency
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

      const SizedBox(height: 30),

      // title: choose your materials:
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

      const SizedBox(height: 30),

      // title: choose your materials:
      Text(heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColours.backgroundOpp)),

      SizedBox(height: 20),
    ]);
  }

  // WIDGET COMPONENTS:

  static Widget headingDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
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

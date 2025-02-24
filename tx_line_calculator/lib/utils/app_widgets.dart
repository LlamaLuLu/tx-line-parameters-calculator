import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';

class AppWidgets extends StatelessWidget {
  const AppWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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

  static Widget backBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20), // Adjust padding for spacing
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 30, color: AppColours.primary),
        ),
      ),
    );
  }

  static Widget nextBtn(BuildContext context, String route) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55, right: 45), // Adjust spacing
        child: ElevatedButton(
          onPressed: () {
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

  static Widget geometryTitle(BuildContext context, String heading) {
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
}

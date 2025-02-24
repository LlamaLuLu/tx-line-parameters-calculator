import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class InsulatorsPage extends StatelessWidget {
  const InsulatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        // back btn, title, heading
                        AppWidgets.materialsTitle(context, 'Insulator'),

                        // 2 columns: button 1 "air", button 2 "polythylene"
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Button 1: Copper
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20), // Adjust spacing
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add onPressed functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColours.accent, // Background color
                                      foregroundColor:
                                          AppColours.accentOpp, // Text color
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Smooth rounded corners
                                      ),
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40), // Same height
                                    ),
                                    child: const Text('Air'),
                                  ),
                                ),
                              ),

                              // Button 2: Aluminium
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20), // Adjust spacing
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add onPressed functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColours
                                          .secondary, // Background color
                                      foregroundColor:
                                          AppColours.secondaryOpp, // Text color
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Smooth rounded corners
                                      ),
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40), // Same height
                                    ),
                                    child: const Text('Polythylene'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // divider: or
                        AppWidgets.orDivider(),

                        const SizedBox(height: 15),

                        // µ & text field
                        InputFields.textField(false, 'µ'),
                        // epsilon & text field
                        InputFields.textField(false, 'ε'),
                        // sigma & text field
                        InputFields.textField(false, 'σ'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // next button
        AppWidgets.nextBtn(context, '/frequency'),
      ])),
    );
  }
}

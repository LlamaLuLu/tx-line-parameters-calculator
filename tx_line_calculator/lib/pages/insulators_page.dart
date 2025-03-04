import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class InsulatorsPage extends StatefulWidget {
  const InsulatorsPage({super.key});

  @override
  State<InsulatorsPage> createState() => _InsulatorsPageState();
}

class _InsulatorsPageState extends State<InsulatorsPage> {
  final TextEditingController muRController = TextEditingController();
  final TextEditingController epsilonRController = TextEditingController();
  final TextEditingController sigmaController = TextEditingController();

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

                        // µR & text field
                        InputFields.textField(
                            hasSubscript: true,
                            label: 'µ',
                            controller: muRController,
                            subscript: 'r',
                            hintText: 'Enter value (\u00D7E-6)'),
                        // epsilonR & text field
                        InputFields.textField(
                            hasSubscript: true,
                            label: 'ε',
                            controller: epsilonRController,
                            subscript: 'r'),
                        // sigma & text field
                        InputFields.textField(
                            label: 'σ',
                            controller: sigmaController,
                            hintText: 'Enter value (\u00D7E-6)'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // next button
        AppWidgets.nextBtnInsulator(
          context,
          '/frequency',
          muRController,
          epsilonRController,
          sigmaController,
        )
      ])),
    );
  }
}

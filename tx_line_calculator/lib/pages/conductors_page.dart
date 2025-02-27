import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';
import 'package:tx_line_calculator/utils/user_inputs.dart';

class ConductorsPage extends StatefulWidget {
  const ConductorsPage({super.key});

  @override
  State<ConductorsPage> createState() => _ConductorsPageState();
}

class _ConductorsPageState extends State<ConductorsPage> {
  final TextEditingController muCController = TextEditingController();
  final TextEditingController sigmaCController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
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
                            AppWidgets.materialsTitle(context, 'Conductor'),

                            // 2 columns: button 1 "copper", button 2 "aluminium"
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                          backgroundColor: AppColours
                                              .accent, // Background color
                                          foregroundColor: AppColours
                                              .accentOpp, // Text color
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
                                        child: const Text('Copper'),
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
                                          foregroundColor: AppColours
                                              .secondaryOpp, // Text color
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
                                        child: const Text('Aluminium'),
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

                            // µ_c, sigma_c
                            InputFields.textField(
                                hasSubscript: true,
                                label: 'µ',
                                controller: muCController,
                                subscript: 'c'),
                            InputFields.textField(
                                hasSubscript: true,
                                label: 'σ',
                                controller: sigmaCController,
                                subscript: 'c'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // next button
            AppWidgets.nextBtnConductor(
                context,
                '/insulators',
                double.tryParse(muCController.text.trim()) ?? 0.0,
                double.tryParse(sigmaCController.text.trim()) ?? 0.0),
          ],
        ),
      ),
    );
  }
}

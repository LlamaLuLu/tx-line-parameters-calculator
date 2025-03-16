import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

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

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Preset 1: copper
                                  AppWidgets.materialPresetBtn(
                                    context,
                                    'Copper',
                                    AppColours.accentOpp,
                                    AppColours.accent,
                                    '/insulators',
                                  ),

                                  // Preset 2: aluminium
                                  AppWidgets.materialPresetBtn(
                                    context,
                                    'Aluminium',
                                    AppColours.secondaryOpp,
                                    AppColours.secondary,
                                    '/insulators',
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Preset 3: gold
                                  AppWidgets.materialPresetBtn(
                                    context,
                                    'Gold',
                                    AppColours.accentOpp,
                                    const Color.fromARGB(255, 227, 214, 170),
                                    '/insulators',
                                  ),

                                  // Preset 4: silver
                                  AppWidgets.materialPresetBtn(
                                    context,
                                    'Silver',
                                    AppColours.secondaryOpp,
                                    const Color.fromARGB(255, 205, 225, 228),
                                    '/insulators',
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
                                subscript: 'c',
                                hintText: 'Enter value (\u00D7E-6)'),
                            InputFields.textField(
                                hasSubscript: true,
                                label: 'σ',
                                controller: sigmaCController,
                                subscript: 'c',
                                hintText: 'Enter value (\u00D7E7)'),
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
              muCController,
              sigmaCController,
            ),
          ],
        ),
      ),
    );
  }
}

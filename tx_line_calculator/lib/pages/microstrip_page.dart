import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class MicrostripPage extends StatefulWidget {
  const MicrostripPage({super.key});

  @override
  State<MicrostripPage> createState() => _MicrostripPageState();
}

class _MicrostripPageState extends State<MicrostripPage> {
  final TextEditingController wController = TextEditingController();
  final TextEditingController hController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // title
                        AppWidgets.anyTitle(context, 'Microstrip Line'),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/microstrip_diag.PNG',
                              fit: BoxFit.cover),
                        ),

                        // heading: "Enter Parameters:"
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 35, bottom: 10, top: 25),
                            child: Text("Enter Parameters:",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColours.darkAccent)),
                          ),
                        ),

                        // 2 text fields: a, b
                        InputFields.textField(
                            label: 'w',
                            controller: wController,
                            hintText: 'Enter value in mm'),
                        InputFields.textField(
                            label: 'h ',
                            controller: hController,
                            hintText: 'Enter value in mm'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // evaluate btn
            AppWidgets.evaluateBtn(
              context,
              4,
              wController,
              hController,
            ),
          ],
        ),
      ),
    );
  }
}

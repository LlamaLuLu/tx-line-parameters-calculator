import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class ParallelPlate extends StatefulWidget {
  const ParallelPlate({super.key});

  @override
  State<ParallelPlate> createState() => _ParallelPlateState();
}

class _ParallelPlateState extends State<ParallelPlate> {
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
                        AppWidgets.anyTitle(context, 'Parallel Plate'),

                        SizedBox(height: 30),

                        // divider
                        AppWidgets.headingDivider(),

                        // heading: "Enter Parameters:"
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 35, bottom: 15),
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
                            label: 'w', controller: wController),
                        InputFields.textField(
                            label: 'h', controller: hController),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // evaluate btn
            AppWidgets.evaluateBtn(
              context,
              3,
              wController,
              hController,
            ),
          ],
        ),
      ),
    );
  }
}

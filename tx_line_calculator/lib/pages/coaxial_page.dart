import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class CoaxialPage extends StatefulWidget {
  const CoaxialPage({super.key});

  @override
  State<CoaxialPage> createState() => _CoaxialPageState();
}

class _CoaxialPageState extends State<CoaxialPage> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();

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
                        AppWidgets.anyTitle(context, 'Coaxial'),

                        Image.asset('assets/coaxial_diag.PNG', height: 240),

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
                            label: 'a',
                            controller: aController,
                            hintText: 'Enter value in mm'),
                        InputFields.textField(
                            label: 'b',
                            controller: bController,
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
              1,
              aController,
              bController,
            ),
          ],
        )));
  }
}

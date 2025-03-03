import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class TwoWirePage extends StatefulWidget {
  const TwoWirePage({super.key});

  @override
  State<TwoWirePage> createState() => _TwoWirePageState();
}

class _TwoWirePageState extends State<TwoWirePage> {
  final TextEditingController DController = TextEditingController();
  final TextEditingController dController = TextEditingController();

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
                        AppWidgets.anyTitle(context, 'Two-Wire'),

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
                            label: 'D', controller: DController),
                        InputFields.textField(
                            label: 'd', controller: dController),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // evaluate btn
            AppWidgets.evaluateBtn(
              context,
              2,
              DController,
              dController,
            ),
          ],
        )));
  }
}

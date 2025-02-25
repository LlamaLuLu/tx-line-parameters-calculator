import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //title
                      AppWidgets.withHistoryTitle(context, 'Results'),

                      // scrolling wheel of circuit diagram & 3d model of geometry
                      SizedBox(height: 120),

                      // table of calculated parameters

                      // divider
                      AppWidgets.headingDivider(),

                      // toggle heading: "Your Inputs:"
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, bottom: 15),
                          child: Text("Your Inputs:",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColours.darkAccent)),
                        ),
                      ),

                      // table of parameters & usr input values
                    ],
                  ),
                ),

                // row: history btn, regenerate btn

                // regenerate btn at btm center
                AppWidgets.regenBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

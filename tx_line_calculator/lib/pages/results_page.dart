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
                      AppWidgets.anyTitle(context, 'Results'),

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // round btn with history icon at btm left
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/history');
                            },
                            backgroundColor: AppColours
                                .secondary, // Change to fit your theme
                            elevation: 4,
                            shape: const CircleBorder(),
                            child: Icon(
                              Icons.history,
                              color:
                                  AppColours.ivory, // Change to fit your theme
                              size: 28,
                            ),
                          ),
                        ),
                      ),

                      // regenerate btn at btm center
                      AppWidgets.regenBtn(context),

                      SizedBox(width: 50),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

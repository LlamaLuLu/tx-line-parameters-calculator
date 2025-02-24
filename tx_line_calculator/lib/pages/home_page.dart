import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                // title: Tx Line Parameters
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text('Tx Line\nParameters',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColours.backgroundOpp)),
                ),

                // circuit diagram image

                // additional: history button
              ],
            ),
          ),

          // start button
          AppWidgets.startBtn(context),
        ]),
      ),
    );
  }
}

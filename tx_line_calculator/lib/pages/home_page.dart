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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(children: [
            // history btn
            AppWidgets.historyBtn(context),

            Center(
              child: Column(
                children: [
                  // title: Tx Line Parameters
                  Padding(
                    padding: const EdgeInsets.only(top: 90, bottom: 50),
                    child: Text('Tx Line\nParameters',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColours.backgroundOpp)),
                  ),

                  // circuit diagram image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        Image.asset('assets/equiv_cct.PNG', fit: BoxFit.cover),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Lumped Element Model',
                        style: TextStyle(
                            fontSize: 16, color: AppColours.darkAccent)),
                  ),

                  // additional: history button
                ],
              ),
            ),

            // start button
            AppWidgets.startBtn(context),
          ]),
        ),
      ),
    );
  }
}

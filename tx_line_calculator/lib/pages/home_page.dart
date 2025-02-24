import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // title: Tx Line Parameters
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Text('Tx Line\nParameters',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColours.backgroundOpp)),
              ),

              // circuit diagram image

              // additional: history button

              SizedBox(height: 600),

              // start button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/conductors');
                },
                child: Text('Start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColours.primary, // Background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 18), // Padding
                  foregroundColor: AppColours
                      .background, // Text color (use foregroundColor for text color)
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Smooth rounded corners
                  ),
                  elevation: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

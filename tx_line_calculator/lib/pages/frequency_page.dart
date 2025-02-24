import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class FrequencyPage extends StatelessWidget {
  const FrequencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
          child: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                // back btn, title, heading
                AppWidgets.materialsTitle(context, 'Frequency'),

                // f & text field
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10), // More balanced padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Aligns text & input properly
                    children: [
                      // µ_c Label with proper Unicode symbol
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColours.darkAccent,
                          ),
                          children: [
                            TextSpan(text: 'f'), // Proper micro symbol
                          ],
                        ),
                      ),

                      const SizedBox(
                          width: 20), // Spacing between label & input field

                      // Text Field
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter value',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColours.darkAccent,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColours.darkAccent,
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColours.darkAccent,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColours.darkAccent,
                          ),
                          keyboardType:
                              TextInputType.number, // Allows numeric input
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //next button
        AppWidgets.nextBtn(context, '/geometry_opt'),
      ])),
    );
  }
}

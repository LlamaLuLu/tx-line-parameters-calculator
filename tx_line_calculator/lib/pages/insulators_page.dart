import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class InsulatorsPage extends StatelessWidget {
  const InsulatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    // back btn, title, heading
                    AppWidgets.materialsTitle(context, 'Insulator'),

                    // 2 columns: button 1 "air", button 2 "polythylene"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Button 1: Copper
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20), // Adjust spacing
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add onPressed functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColours.accent, // Background color
                                  foregroundColor:
                                      AppColours.accentOpp, // Text color
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Smooth rounded corners
                                  ),
                                  elevation: 4,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40), // Same height
                                ),
                                child: const Text('Air'),
                              ),
                            ),
                          ),

                          // Button 2: Aluminium
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20), // Adjust spacing
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add onPressed functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColours.secondary, // Background color
                                  foregroundColor:
                                      AppColours.secondaryOpp, // Text color
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Smooth rounded corners
                                  ),
                                  elevation: 4,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40), // Same height
                                ),
                                child: const Text('Polythylene'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // divider: or
                    AppWidgets.orDivider(),

                    const SizedBox(height: 15),

                    // µ & text field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10), // More balanced padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Aligns text & input properly
                        children: [
                          // µ
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColours.darkAccent,
                              ),
                              children: [
                                TextSpan(text: 'μ'), // Proper micro symbol
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
                                  fontSize: 14,
                                  color: AppColours.darkAccent,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColours.darkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColours.darkAccent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
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

                    // epsilon & text field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10), // More balanced padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Aligns text & input properly
                        children: [
                          // µ_c Label with proper Unicode symbol
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColours.darkAccent,
                              ),
                              children: [
                                TextSpan(text: 'ε'), // Proper micro symbol
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
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColours.darkAccent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
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

                    // sigma & text field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10), // More balanced padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Aligns text & input properly
                        children: [
                          // µ_c Label with proper Unicode symbol
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColours.darkAccent,
                              ),
                              children: [
                                TextSpan(text: 'σ'), // Proper micro symbol
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
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColours.darkAccent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
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
          ],
        ),

        // next button
        AppWidgets.nextBtn(context, '/frequency'),
      ])),
    );
  }
}

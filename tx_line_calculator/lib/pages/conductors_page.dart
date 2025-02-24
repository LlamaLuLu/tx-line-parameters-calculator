import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';

class ConductorsPage extends StatelessWidget {
  const ConductorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  // back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20), // Adjust padding for spacing
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,
                            size: 30, color: AppColours.primary),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // title: choose your materials:
                  Text('Choose your materials:',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColours.backgroundOpp)),

                  SizedBox(height: 45),

                  // heading: conductor
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text('Conductor',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColours.darkAccent)),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 2 columns: button 1 "copper", button 2 "aluminium"
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
                                  fontSize: 20,
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
                              child: const Text('Copper'),
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
                                  fontSize: 20,
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
                              child: const Text('Aluminium'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // divider: or
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColours.darkAccent, // Line color
                            thickness: 1.5, // Line thickness
                            endIndent: 15, // Space between line and text
                          ),
                        ),
                        Text(
                          'or',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColours.darkAccent,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColours.darkAccent, // Line color
                            thickness: 1.5, // Line thickness
                            indent: 15, // Space between line and text
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // µ_c & text field
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
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColours.darkAccent,
                            ),
                            children: [
                              TextSpan(text: 'μ'), // Proper micro symbol
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: Offset(0, 4), // Moves subscript down
                                  child: Text(
                                    'c',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w600, // Match boldness
                                      color:
                                          AppColours.darkAccent, // Match color
                                    ), // Subscript c
                                  ),
                                ),
                              ),
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

                  // sigma_c & text field
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
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColours.darkAccent,
                            ),
                            children: [
                              TextSpan(text: 'σ'), // Proper micro symbol
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: Offset(0, 4), // Moves subscript down
                                  child: Text(
                                    'c',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w600, // Match boldness
                                      color:
                                          AppColours.darkAccent, // Match color
                                    ), // Subscript c
                                  ),
                                ),
                              ),
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

                  SizedBox(height: 200),

                  // next button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, right: 30), // Adjust spacing
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/insulators'); // Replace with your actual route
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColours.primary, // Use your theme color
                          foregroundColor:
                              AppColours.background, // White text for contrast
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Smooth rounded corners
                          ),
                          elevation: 5, // Slight shadow for depth
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Next'), // Button text
                            SizedBox(width: 8), // Space between text and icon
                            Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: AppColours.background,
                            ), // Arrow icon
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                // title
                AppWidgets.anyTitle(context, 'History')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveToHistory() {
    // get current date & time as heading
    // take results & user input from results page
    // create new entry in history page -> populate list
    // save to local storage
  }
}

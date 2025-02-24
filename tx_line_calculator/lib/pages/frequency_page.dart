import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class FrequencyPage extends StatelessWidget {
  const FrequencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      resizeToAvoidBottomInset: true,
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
                InputFields.textField(false, 'f')
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

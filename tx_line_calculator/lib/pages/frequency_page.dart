import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';

class FrequencyPage extends StatefulWidget {
  const FrequencyPage({super.key});

  @override
  State<FrequencyPage> createState() => _FrequencyPageState();
}

class _FrequencyPageState extends State<FrequencyPage> {
  final TextEditingController fController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    // back btn, title, heading
                    AppWidgets.materialsTitle(
                        context, 'Choose your materials:', 'Frequency'),

                    // f & text field
                    InputFields.textField(
                        label: 'f',
                        controller: fController,
                        hintText: 'Enter value (\u00D7E9)'),
                  ],
                ),
              ),
            ),

            //next button
            AppWidgets.nextBtnFrequency(context, '/geometry_opt', fController),
          ],
        ),
      ),
    );
  }
}

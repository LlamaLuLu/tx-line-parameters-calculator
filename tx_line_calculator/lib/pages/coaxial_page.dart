import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class CoaxialPage extends StatelessWidget {
  const CoaxialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColours.background,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              // title
              AppWidgets.geometryTitle(context, 'Coaxial'),
            ],
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';

class GeometryPage extends StatelessWidget {
  const GeometryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Column(
          children: [
            // title
            AppWidgets.geometryTitle(context),

            // 3 options: 1. coaxial, 2. 2-wire, 3. parallel plate
          ],
        ),
      ),
    );
  }
}

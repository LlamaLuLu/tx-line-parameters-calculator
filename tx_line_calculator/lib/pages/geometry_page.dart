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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // title
              AppWidgets.anyTitle(context, 'Choose your geometry:'),

              // 3 options: 1. coaxial, 2. 2-wire, 3. parallel plate
              AppWidgets.geometryOptBtn(
                context,
                '/coaxial',
                'Coaxial',
                AppColours.darkAccentOpp,
                AppColours.darkAccent,
              ),

              // Button 2: 2-wire
              AppWidgets.geometryOptBtn(
                context,
                '/2_wire',
                'Two-Wire',
                AppColours.primaryOpp,
                AppColours.primary,
              ),

              // Button 3: Parallel Plate
              AppWidgets.geometryOptBtn(
                context,
                '/parallel_plate',
                'Parallel Plate',
                AppColours.primary,
                AppColours.secondary,
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

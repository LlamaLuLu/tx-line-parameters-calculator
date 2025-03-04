import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  double? rS, r, l, g, c;
  int? geometryCode;
  String? geometry;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    // Fetch results from UserInputData
    geometryCode = await UserInputData.getSelectedGeometry();
    if (geometryCode == 1) {
      geometry = 'Coaxial';
    } else if (geometryCode == 2) {
      geometry = '2-Wire';
    } else if (geometryCode == 3) {
      geometry = 'Parallel Plate';
    }

    rS = await UserInputData.getRS();
    if (geometryCode == 1) {
      r = await UserInputData.getRCoaxial();
      l = await UserInputData.getLCoaxial();
      g = await UserInputData.getGCoaxial();
      c = await UserInputData.getCCoaxial();
    } else if (geometryCode == 2) {
      r = await UserInputData.getR2Wire();
      l = await UserInputData.getL2Wire();
      g = await UserInputData.getG2Wire();
      c = await UserInputData.getC2Wire();
    } else if (geometryCode == 3) {
      r = await UserInputData.getRParallel();
      l = await UserInputData.getLParallel();
      g = await UserInputData.getGParallel();
      c = await UserInputData.getCParallel();
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // Make the entire body scrollable
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // title
                      AppWidgets.withHistoryTitle(context, 'Results'),

                      // table of calculated parameters
                      Table(
                        border: TableBorder.all(
                            color: AppColours.darkAccent, width: 1),
                        columnWidths: {
                          0: FixedColumnWidth(110),
                          1: FixedColumnWidth(130),
                          2: FixedColumnWidth(70),
                        },
                        children: [
                          // Table Header
                          TableRow(
                            decoration:
                                BoxDecoration(color: AppColours.primary),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Parameter',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Value',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Unit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                            ],
                          ),
                          // Data Rows
                          _buildTableRow(
                              'Rₛ', rS?.toStringAsExponential(2), '\u03A9/km'),
                          _buildTableRow(
                              "R'", r?.toStringAsExponential(2), '\u03A9/km'),
                          _buildTableRow(
                              "L'", l?.toStringAsExponential(2), 'H/km'),
                          _buildTableRow(
                              "G'", g?.toStringAsExponential(2), 'S/km'),
                          _buildTableRow(
                              "C'", c?.toStringAsExponential(2), 'F/km'),
                        ],
                      ),

                      // divider
                      //AppWidgets.headingDivider(),

                      // toggle heading: "Your Inputs:"
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            'Your Inputs:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColours.darkAccent,
                            ),
                          ),
                          children: [
                            // CONTENTS
                            // table of parameters & user input values:
                            // 1. conductor: muC, sigmaC
                            // 2. insulator: muR, epsilonR, sigma
                            // 3. frequency
                            // 4. geometry: shape, dimensions (param1, param2)
                          ],
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          childrenPadding: const EdgeInsets.only(
                              bottom: 30, left: 30, right: 30, top: 10),
                          expandedAlignment: Alignment.topLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          onExpansionChanged: (bool expanded) {},
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Regenerate button at the bottom
            AppWidgets.regenBtn(context),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String param, String? value, String unit) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(param,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColours.backgroundOpp)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value ?? 'N/A',
            style: TextStyle(color: AppColours.backgroundOpp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(unit, style: TextStyle(color: AppColours.backgroundOpp)),
        ),
      ],
    );
  }
}

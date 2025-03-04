import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/swipe_image_widget.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  double? rS, r, l, g, c;
  double? muC, sigmaC, muR, epsilonR, sigma, f, param1, param2;
  int? geometryCode;
  String? geometry;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    // Fetch results from UserInputData
    muC = await UserInputData.getMuC();
    sigmaC = await UserInputData.getSigmaC();
    muR = await UserInputData.getMuR();
    epsilonR = await UserInputData.getEpsilonR();
    sigma = await UserInputData.getSigma();
    f = await UserInputData.getF();

    geometryCode = await UserInputData.getSelectedGeometry();
    if (geometryCode == 1) {
      geometry = 'Coaxial';
      param1 = await UserInputData.getA();
      param2 = await UserInputData.getB();
    } else if (geometryCode == 2) {
      geometry = '2-Wire';
      param1 = await UserInputData.getD();
      param2 = await UserInputData.getDiameter();
    } else if (geometryCode == 3) {
      geometry = 'Parallel Plate';
      param1 = await UserInputData.getW();
      param2 = await UserInputData.getH();
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
        child: Stack(
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
                          1: FixedColumnWidth(135),
                          2: FixedColumnWidth(65),
                        },
                        children: [
                          // Table Header
                          TableRow(
                            decoration:
                                BoxDecoration(color: AppColours.primary),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text('Parameter',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text('Value',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text('Unit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColours.ivory)),
                              ),
                            ],
                          ),
                          // Data Rows
                          _buildTableRow(
                              'Rs', rS?.toStringAsExponential(2), '\u03A9/m'),
                          _buildTableRow(
                              "R'", r?.toStringAsExponential(2), '\u03A9/m'),
                          _buildTableRow(
                              "L'", l?.toStringAsExponential(2), 'H/m'),
                          _buildTableRow(
                              "G'", g?.toStringAsExponential(2), 'S/m'),
                          _buildTableRow(
                              "C'", c?.toStringAsExponential(2), 'F/m'),
                        ],
                      ),

                      // chosen geometry
                      SwipeImageWidget(
                        imagePaths: [
                          if (geometryCode == 1) "assets/coaxial_diag.PNG",
                          if (geometryCode == 2) "assets/2_wire_diag.PNG",
                          if (geometryCode == 3)
                            "assets/parallel_plate_diag.PNG",
                          "assets/equiv_cct.PNG",
                        ],
                      ),

                      AppWidgets.dividerTop(),

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
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          childrenPadding: const EdgeInsets.only(
                              bottom: 30, left: 15, right: 15),
                          expandedAlignment: Alignment.topLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          onExpansionChanged: (bool expanded) {},
                          controlAffinity: ListTileControlAffinity.leading,
                          children: [
                            Card(
                              margin: const EdgeInsets.only(
                                  left: 12, right: 12, top: 5, bottom: 85),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(
                                    color: AppColours.secondary, width: 1.5),
                              ),
                              color: AppColours.ivory,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // conductor
                                    _sectionTitle("Conductor Properties"),
                                    _buildStyledDataRow("μC",
                                        muC!.toStringAsExponential(2), "H/m"),
                                    _buildStyledDataRow(
                                        "σC",
                                        sigmaC!.toStringAsExponential(2),
                                        "S/m"),
                                    // insulator
                                    _sectionTitle("Insulator Properties"),
                                    _buildStyledDataRow("μR",
                                        muR!.toStringAsExponential(2), "H/m"),
                                    _buildStyledDataRow(
                                        "εR",
                                        epsilonR!.toStringAsExponential(2),
                                        "F/m"),
                                    _buildStyledDataRow("σ",
                                        sigma!.toStringAsExponential(2), "S/m"),
                                    // frequency
                                    _sectionTitle("Operating Frequency"),
                                    _buildStyledDataRow("Frequency",
                                        f!.toStringAsExponential(2), "Hz"),
                                    // geometry
                                    _sectionTitle("Geometry"),
                                    _buildStyledDataRow("Shape", geometry, ""),
                                    _buildStyledDataRow("Parameter 1",
                                        param1!.toStringAsExponential(2), "m"),
                                    _buildStyledDataRow("Parameter 2",
                                        param2!.toStringAsExponential(2), "m"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      AppWidgets.dividerBottom()
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(param,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColours.backgroundOpp)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            value ?? 'N/A',
            style: TextStyle(fontSize: 14, color: AppColours.backgroundOpp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(unit,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColours.backgroundOpp)),
        ),
      ],
    );
  }

  Widget _buildStyledDataRow(String label, dynamic value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColours.accent,
            ),
          ),
          Text(
            value != null ? "$value $unit" : "N/A",
            style: TextStyle(
              fontSize: 15,
              color: AppColours.secondaryOpp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColours.darkAccent,
        ),
      ),
    );
  }
}

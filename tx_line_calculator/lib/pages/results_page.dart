import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  double? muC, sigmaC, muR, epsilonR, sigma, f, param1, param2;
  double? rS, r, l, g, c, alpha, beta, muP, lambda, z0Lossless, sRatio;
  Complex? z0;
  int? geometryCode;
  String? geometry, param1Text, param2Text;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    // fetch user inputs
    muC = await UserInputData.getMuC();
    sigmaC = await UserInputData.getSigmaC();
    muR = await UserInputData.getMuR();
    epsilonR = await UserInputData.getEpsilonR();
    sigma = await UserInputData.getSigma();
    f = await UserInputData.getF();

    // identify geometry
    geometryCode = await UserInputData.getSelectedGeometry();
    if (geometryCode == 1) {
      geometry = 'Coaxial';
      param1 = (await UserInputData.getA())! * 1000;
      param1Text = 'a';
      param2 = (await UserInputData.getB())! * 1000;
      param2Text = 'b';
    } else if (geometryCode == 2) {
      geometry = '2-Wire';
      param1 = (await UserInputData.getD())! * 1000;
      param1Text = 'D';
      param2 = (await UserInputData.getDiameter())! * 1000;
      param2Text = 'd';
    } else if (geometryCode == 3) {
      geometry = 'Parallel Plate';
      param1 = (await UserInputData.getW())! * 1000;
      param1Text = 'w';
      param2 = (await UserInputData.getH())! * 1000;
      param2Text = 'h';
    } else if (geometryCode == 4) {
      geometry = 'Microstrip';
      param1 = (await UserInputData.getWMicrostrip())! * 1000;
      param1Text = 'w';
      param2 = (await UserInputData.getHMicrostrip())! * 1000;
      param2Text = 'h';
      sRatio = await UserInputData.getSRatio();
    }

    // fetch calculated results
    rS = await UserInputData.getRS();
    r = await UserInputData.getR();
    l = await UserInputData.getL();
    g = await UserInputData.getG();
    c = await UserInputData.getC();

    alpha = await UserInputData.getAlpha();
    beta = await UserInputData.getBeta();
    z0 = await UserInputData.getZ0();
    z0Lossless = await UserInputData.getZ0Lossless();
    muP = await UserInputData.getMuP();
    lambda = await UserInputData.getLambda();

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
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
                  border:
                      TableBorder.all(color: AppColours.darkAccent, width: 1),
                  columnWidths: {
                    0: FixedColumnWidth(110),
                    1: FixedColumnWidth(135),
                    2: FixedColumnWidth(65),
                  },
                  children: [
                    // Table Header
                    TableRow(
                      decoration: BoxDecoration(color: AppColours.primary),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('Parameter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColours.ivory)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('Value',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColours.ivory)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
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
                    if (geometryCode != 4)
                      _buildTableRow('Rs',
                          rS?.toStringAsExponential(3) ?? "null", '\u03A9/m'),

                    _buildTableRow("R'", r?.toStringAsExponential(3) ?? "null",
                        '\u03A9/m'),
                    _buildTableRow(
                        "L'", l?.toStringAsExponential(3) ?? "null", 'H/m'),
                    _buildTableRow(
                        "G'", g?.toStringAsExponential(3) ?? "null", 'S/m'),
                    _buildTableRow(
                        "C'", c?.toStringAsExponential(3) ?? "null", 'F/m'),
                    _buildTableRow("\u03B1",
                        alpha?.toStringAsExponential(3) ?? "null", 'Np/m'),
                    _buildTableRow("\u03B2",
                        beta?.toStringAsExponential(3) ?? "null", 'rad/m'),
                    _buildTableRow("\u00B5P",
                        muP?.toStringAsExponential(3) ?? "null", 'm/s'),
                    _buildTableRow("\u03BB",
                        lambda?.toStringAsExponential(3) ?? "null", "m"),
                    _buildTableRow(
                        "Z0",
                        (geometryCode == 4)
                            ? z0Lossless?.toStringAsExponential(3)
                            : "(${z0?.real.toStringAsExponential(3)}) + j(${z0?.imaginary.toStringAsExponential(3)})",
                        '\u03A9'),
                  ],
                ),

                // chosen geometry
                SwipeImageWidget(
                  imagePaths: [
                    if (geometryCode == 1) "assets/coaxial_diag.PNG",
                    if (geometryCode == 2) "assets/2_wire_diag.PNG",
                    if (geometryCode == 3) "assets/parallel_plate_diag.PNG",
                    if (geometryCode == 4) "assets/microstrip_diag.PNG",
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
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                    childrenPadding:
                        const EdgeInsets.only(bottom: 30, left: 15, right: 15),
                    expandedAlignment: Alignment.topLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    onExpansionChanged: (bool expanded) {},
                    controlAffinity: ListTileControlAffinity.leading,
                    children: [
                      Card(
                        margin:
                            const EdgeInsets.only(left: 12, right: 12, top: 5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                              color: AppColours.secondary, width: 1.5),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // conductor
                              _sectionTitle("Conductor Properties"),
                              _buildStyledDataRow(
                                  "μC", muC!.toStringAsExponential(2), "H/m"),
                              _buildStyledDataRow("σC",
                                  sigmaC!.toStringAsExponential(2), "S/m"),
                              // insulator
                              _sectionTitle("Insulator Properties"),
                              _buildStyledDataRow(
                                  "μR", muR!.toStringAsExponential(2), "H/m"),
                              _buildStyledDataRow("εR",
                                  epsilonR!.toStringAsExponential(2), "F/m"),
                              _buildStyledDataRow(
                                  "σ", sigma!.toStringAsExponential(2), "S/m"),
                              // frequency
                              _sectionTitle("Operating Frequency"),
                              _buildStyledDataRow("Frequency",
                                  f!.toStringAsExponential(2), "Hz"),
                              // geometry
                              _sectionTitle("Geometry"),
                              _buildStyledDataRow(
                                  "Shape", "$geometry Line", ""),
                              _buildStyledDataRow(param1Text!, param1!, "mm"),
                              _buildStyledDataRow(param2Text!, param2!, "mm"),
                              if (geometryCode == 4)
                                _buildStyledDataRow(
                                    "w / h", sRatio!.toStringAsFixed(6), ""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                AppWidgets.dividerBottom(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Regenerate btn at bottom left
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: AppWidgets.regenBtn(context),
                    ),

                    // continue btn at bottom right
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: AppWidgets.continueBtn(context),
                    ),
                  ],
                )
              ],
            ),
          ),
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
                  fontWeight: FontWeight.w600,
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

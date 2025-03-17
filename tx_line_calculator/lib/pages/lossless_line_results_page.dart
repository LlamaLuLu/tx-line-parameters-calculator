import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/swipe_image_widget.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class LosslessLineResultsPage extends StatefulWidget {
  const LosslessLineResultsPage({super.key});

  @override
  State<LosslessLineResultsPage> createState() =>
      _LosslessLineResultsPageState();
}

class _LosslessLineResultsPageState extends State<LosslessLineResultsPage> {
  Complex? zL;
  double? z0Lossless, l;
  Complex? bigGamma, zIn;
  double? S, bigGammaMag, bigGammaPhaseRad, bigGammaPhaseDeg;
  int? geometryCode;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    // fetch geometry code
    geometryCode = await UserInputData.getSelectedGeometry();
    // fetch user inputs
    zL = await UserInputData.getZL();
    z0Lossless = await UserInputData.getZ0Lossless();
    l = await UserInputData.getLength();

    // fetch calculated values
    bigGamma = await UserInputData.getBigGamma();
    bigGammaMag = bigGamma!.abs();
    bigGammaPhaseRad = bigGamma!.argument();
    bigGammaPhaseDeg = bigGammaPhaseRad! * 180 / 3.14159;
    S = await UserInputData.getS();
    zIn = await UserInputData.getZIn();

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
                    1: FixedColumnWidth(140),
                    2: FixedColumnWidth(60),
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
                    _buildTableRow(
                        '\u0393',
                        "${bigGammaMag!.toStringAsExponential(3)} * \ne^(${bigGammaPhaseDeg!.toStringAsExponential(3)})",
                        '-'),
                    _buildTableRow("S", S!.toStringAsExponential(3), '-'),
                    _buildTableRow(
                        "Zin",
                        "(${zIn!.real.toStringAsExponential(3)}) + \nj(${zIn!.imaginary.toStringAsExponential(3)})",
                        'Ω'),
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
                              // Lossless Line
                              _sectionTitle("Lossless Line Properties"),
                              _buildStyledDataRow("z0",
                                  z0Lossless!.toStringAsExponential(2), "H/m"),
                              _buildStyledDataRow(
                                  "zL",
                                  "(${zL!.real.toStringAsExponential(3)}) + \nj(${zL!.imaginary.toStringAsExponential(3)})",
                                  "S/m"),
                              _buildStyledDataRow(
                                  "Length", l!.toStringAsExponential(3), "m"),
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
                    // Create new tx line btn
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: AppWidgets.newLineBtn(context),
                    ),

                    // Regenerate btn at bottom left
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: AppWidgets.regenLosslessBtn(context),
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

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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //title
                      AppWidgets.withHistoryTitle(context, 'Results'),

                      // scrolling wheel of circuit diagram & 3d model of geometry
                      SizedBox(height: 80),

                      // table of calculated parameters
                      Text('You chose geometry: $geometry'),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: {
                          0: FixedColumnWidth(120),
                          1: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('R_s',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(rS?.toStringAsFixed(3) ?? 'N/A'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('R\'',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(r?.toStringAsFixed(3) ?? 'N/A'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('L\'',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(l?.toStringAsFixed(3) ?? 'N/A'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('G\'',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(g?.toStringAsFixed(3) ?? 'N/A'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('C\'',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(c?.toStringAsFixed(3) ?? 'N/A'),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // divider
                      AppWidgets.headingDivider(),

                      // toggle heading: "Your Inputs:"
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, bottom: 15),
                          child: Text("Your Inputs:",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColours.darkAccent)),
                        ),
                      ),

                      // table of parameters & usr input values
                    ],
                  ),
                ),

                // row: history btn, regenerate btn

                // regenerate btn at btm center
                AppWidgets.regenBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

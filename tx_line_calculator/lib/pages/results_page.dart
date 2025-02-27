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
  @override
  void initState() {
    super.initState();
    // This forces a refresh when this screen is initialized
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
                      SizedBox(height: 100),

                      // table of calculated parameters
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("R_S",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FutureBuilder<double?>(
                                    future: UserInputData.getRS(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error');
                                      } else {
                                        return Text(
                                            snapshot.data?.toStringAsFixed(6) ??
                                                'N/A');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("R'")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<double?>(
                                  future: UserInputData.getR(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error');
                                    } else {
                                      return Text(
                                          snapshot.data?.toStringAsFixed(6) ??
                                              'N/A');
                                    }
                                  },
                                ),
                              ),
                            ]),
                            // Similar pattern for L', G', and C'
                            TableRow(children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("L'")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<double?>(
                                  future: UserInputData.getL(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error');
                                    } else {
                                      return Text(
                                          snapshot.data?.toStringAsFixed(6) ??
                                              'N/A');
                                    }
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("G'")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<double?>(
                                  future: UserInputData.getG(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error');
                                    } else {
                                      return Text(
                                          snapshot.data?.toStringAsFixed(6) ??
                                              'N/A');
                                    }
                                  },
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("C'")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<double?>(
                                  future: UserInputData.getC(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error');
                                    } else {
                                      return Text(
                                          snapshot.data?.toStringAsFixed(6) ??
                                              'N/A');
                                    }
                                  },
                                ),
                              ),
                            ]),
                          ],
                        ),
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

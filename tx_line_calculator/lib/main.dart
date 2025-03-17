import 'package:flutter/material.dart';
import 'package:tx_line_calculator/pages/2_wire_page.dart';
import 'package:tx_line_calculator/pages/coaxial_page.dart';
import 'package:tx_line_calculator/pages/conductors_page.dart';
import 'package:tx_line_calculator/pages/frequency_page.dart';
import 'package:tx_line_calculator/pages/geometry_page.dart';
import 'package:tx_line_calculator/pages/history_page.dart';
import 'package:tx_line_calculator/pages/home_page.dart';
import 'package:tx_line_calculator/pages/insulators_page.dart';
import 'package:tx_line_calculator/pages/lossless_line_inputs_page.dart';
import 'package:tx_line_calculator/pages/lossless_line_results_page.dart';
import 'package:tx_line_calculator/pages/microstrip_page.dart';
import 'package:tx_line_calculator/pages/parallel_plate.dart';
import 'package:tx_line_calculator/pages/results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tx Line',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/conductors': (context) => ConductorsPage(),
        '/insulators': (context) => InsulatorsPage(),
        '/frequency': (context) => FrequencyPage(),
        '/geometry_opt': (context) => GeometryPage(),
        '/coaxial': (context) => CoaxialPage(),
        '/2_wire': (context) => TwoWirePage(),
        '/parallel_plate': (context) => ParallelPlate(),
        '/microstrip': (context) => MicrostripPage(),
        '/results': (context) => ResultsPage(),
        '/lossless_inputs': (context) => LosslessLineInputsPage(),
        '/lossless_results': (context) => LosslessLineResultsPage(),
        '/history': (context) => HistoryPage(),
      },
    );
  }
}

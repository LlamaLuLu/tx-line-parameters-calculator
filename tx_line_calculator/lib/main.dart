import 'package:flutter/material.dart';
import 'package:tx_line_calculator/pages/conductors_page.dart';
import 'package:tx_line_calculator/pages/frequency_page.dart';
import 'package:tx_line_calculator/pages/geometry_input_page.dart';
import 'package:tx_line_calculator/pages/geometry_page.dart';
import 'package:tx_line_calculator/pages/home_page.dart';
import 'package:tx_line_calculator/pages/insulators_page.dart';
import 'package:tx_line_calculator/pages/results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tx Line Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/conductors': (context) => ConductorsPage(),
        '/insulators': (context) => InsulatorsPage(),
        '/frequency': (context) => FrequencyPage(),
        '/geometry_opt': (context) => GeometryPage(),
        '/geometry_in': (context) => GeometryInputPage(),
        '/results': (context) => ResultsPage(),
      },
    );
  }
}

// remove next btn from cln & set own bottom right alignment padding
// need page to save user input

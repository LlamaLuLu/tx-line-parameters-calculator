import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:tx_line_calculator/utils/app_colours.dart';
import 'package:tx_line_calculator/utils/app_widgets.dart';
import 'package:tx_line_calculator/utils/input_fields.dart';
import 'package:tx_line_calculator/utils/user_input_data.dart';

class LosslessLineInputsPage extends StatefulWidget {
  const LosslessLineInputsPage({super.key});

  @override
  State<LosslessLineInputsPage> createState() => _LosslessLineInputsPageState();
}

class _LosslessLineInputsPageState extends State<LosslessLineInputsPage> {
  final TextEditingController lambdaController = TextEditingController();
  final TextEditingController z0Controller = TextEditingController();
  final TextEditingController zLReController = TextEditingController();
  final TextEditingController zLImController = TextEditingController();
  final TextEditingController lController = TextEditingController();
  final TextEditingController fractionalController = TextEditingController();
  double? z0Re, z0Im, z0Lossless, lambda;
  Complex? z0;
  double? z0Mag;
  int? geometryCode;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    // fetch geometry code
    geometryCode = await UserInputData.getSelectedGeometry();
    // fetch calculated values
    if (geometryCode == 4)
      z0Mag = await UserInputData.getZ0Lossless();
    else {
      z0 = await UserInputData.getZ0();
      z0Mag = z0!.abs();
    }
    lambda = await UserInputData.getLambda();
    //lambda = lambda! * 1000; // for display in mm

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    // back button
                    AppWidgets.backBtn(context),

                    const SizedBox(height: 5),

                    // title
                    Text('Lossless Line Inputs',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColours.backgroundOpp)),

                    SizedBox(height: 15),

                    InputFields.textField(
                        label: '\u03BB  ',
                        controller: lambdaController,
                        hintText: (lambda != null || lambda != 0)
                            ? 'Enter value in m      |    ${lambda!.toStringAsFixed(2)}'
                            : 'Enter value in m'),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 35, top: 12, bottom: 10),
                        child: Text('Impedances',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColours.darkAccent)),
                      ),
                    ),

                    // z0
                    InputFields.textField(
                        hasSubscript: true,
                        label: 'Z',
                        subscript: '0',
                        controller: z0Controller,
                        hintText: (z0Mag != null || z0Mag != 0)
                            ? 'Enter value               |    ${z0Mag!.toStringAsFixed(2)}'
                            : 'Enter value'),
                    // zL Re
                    InputFields.textField(
                        hasSubscript: true,
                        label: 'Z',
                        subscript: 'L',
                        controller: zLReController,
                        hintText: 'Enter Real value'),
                    // zL Im
                    InputFields.textField(
                        hasSubscript: true,
                        label: 'Z',
                        subscript: 'L',
                        controller: zLImController,
                        hintText: 'Enter Imaginary value'),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 35, top: 12, bottom: 10),
                        child: Text('Wire length',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColours.darkAccent)),
                      ),
                    ),

                    // l
                    InputFields.textField(
                        label: 'L ',
                        controller: lController,
                        hintText: 'Enter wire length in m'),
                    // or divider
                    AppWidgets.orDivider(),
                    // wavelength
                    InputFields.textField(
                      label: 'Factor*\u03BB',
                      controller: fractionalController,
                      hintText: 'Enter fractional value',
                    ),
                  ],
                ),
              ),
            ),

            //next button
            AppWidgets.evalLosslessBtn(
                context,
                '/lossless_results',
                lambdaController,
                z0Controller,
                zLReController,
                zLImController,
                lController,
                fractionalController),
          ],
        ),
      ),
    );
  }
}

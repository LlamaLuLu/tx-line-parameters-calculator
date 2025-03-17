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
                    // back btn, title, heading
                    AppWidgets.materialsTitle(
                        context, 'Lossless Line', 'Impedances'),

                    // z0
                    InputFields.textField(
                        hasSubscript: true,
                        label: 'Z',
                        subscript: '0',
                        controller: z0Controller,
                        hintText: (z0Mag != null)
                            ? 'Enter value         |    ${z0Mag!.toStringAsFixed(2)}'
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
                            left: 35, top: 20, bottom: 10),
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
                        hintText: 'Enter wire length (m)'),
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

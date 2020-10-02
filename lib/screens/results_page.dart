import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(
      {@required this.interpretation,
      @required this.bmiResult,
      @required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: NeumorphicText(
          'BMI Calculator',
          textStyle: NeumorphicTextStyle(
            fontSize: (textScaleFactor * 25),
            fontWeight: FontWeight.bold,
          ),
          style: NeumorphicStyle(
            depth: 1,
            intensity: 1,
            surfaceIntensity: 1,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: NeumorphicText(
                'Your Result',
                style: NeumorphicStyle(
                    depth: 1.2, intensity: 1, surfaceIntensity: 1),
                textStyle: NeumorphicTextStyle(
                    fontSize: textScaleFactor * 60,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Neumorphic(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

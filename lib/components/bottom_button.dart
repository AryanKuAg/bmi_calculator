import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: NeumorphicText(
            buttonTitle,
            textStyle: NeumorphicTextStyle(
                fontSize: textScaleFactor * 30, fontWeight: FontWeight.bold),
            style: NeumorphicStyle(depth: 1, surfaceIntensity: 1),
          ),
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}

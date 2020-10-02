import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NeumorphicIcon(
          icon,
          size: mediaQuery.height * 0.1,
          style: NeumorphicStyle(depth: 1, color: Colors.black),
        ),
        SizedBox(
          height: mediaQuery.height * 0.01,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: textScaleFactor * 18.0,
            color: Color(0xFF8D8E98),
          ),
        )
      ],
    );
  }
}

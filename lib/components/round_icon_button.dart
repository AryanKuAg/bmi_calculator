import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      child: Icon(icon),
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: null,
        surfaceIntensity: 0,
      ),
    );
  }
}

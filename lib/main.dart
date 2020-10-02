import 'package:flutter/material.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      theme: NeumorphicThemeData(depth: 12, lightSource: LightSource.topLeft),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: InputPage(),
        title: Text('BMI Calculator'),
        image: Image.asset('assets/hoho.png'),
        photoSize: 175,
        loaderColor: Colors.pinkAccent,
        loadingText: Text('Are You Ready?'),
      ),
    );
  }
}

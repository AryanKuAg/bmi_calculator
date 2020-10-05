import 'dart:async';
import 'dart:io';

import 'package:bmi_calculator/components/myDonation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Drawer(
      child: Container(
        color: Colors.white70,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                title: Text('Main'),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: Icon(
                      Icons.home_rounded,
                      color: Colors.pinkAccent,
                    ),
                    title: Text(
                      'Overview',
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ),
                onTap: () {
                  if (Navigator.of(context).canPop())
                    Navigator.of(context).pop();
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Rate this app'),
                ),
                onTap: () {
                  LaunchReview.launch(
                      androidAppId: 'xyz.funfury.bmi_calculator');
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Help & Feedback'),
                ),
                onTap: () {
                  LaunchReview.launch(
                      androidAppId: 'xyz.funfury.bmi_calculator',
                      writeReview: true);
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share this app'),
                ),
                onTap: () async {
                  final RenderBox box = context.findRenderObject();
                  await Share.share(
                      'https://play.google.com/store/apps/details?id=xyz.funfury.bmi_calculator',
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.download_rounded),
                  title: Text('More apps'),
                ),
                onTap: () async {
                  //baby
                  if (await canLaunch(
                      'https://play.google.com/store/apps/developer?id=Alemantrix'))
                    launch(
                        'https://play.google.com/store/apps/developer?id=Alemantrix');
                },
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.favorite_border_rounded),
                  title: Text('Donate'),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MyDonation(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// keytool -genkey -v -keystore c:\Users\Aryan\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key

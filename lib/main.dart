//Alrex was here

import 'package:flutter/material.dart';
import 'package:kochbuch/pages/splashscreen.dart';

import 'pages/ShowCat.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kochbuch',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
        home: Splash(),
    );
  }
}


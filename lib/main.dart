//Alrex was here

import 'package:flutter/material.dart';
import 'package:kochbuch/pages/devstart.dart';
import 'package:kochbuch/pages/splashscreen.dart';

import 'pages/recipe.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kochbuch',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
        home: devStart(),
    );
  }
}


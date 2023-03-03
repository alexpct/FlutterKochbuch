//Alrex was here

import 'package:flutter/material.dart';
import 'package:kochbuch/pages/devstart.dart';


void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


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


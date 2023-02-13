import 'package:flutter/material.dart';
import 'package:kochbuch/helper/firstrun.dart';
import 'package:kochbuch/pages/recipe.dart';

class splash extends StatefulWidget {


  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
Future<bool> fr = firstrun();
String text = "Bitte warten";

  @override
  Widget build(BuildContext context) {
    fr.then((value) => {
      {
        if(value) Navigator.push(
            context, MaterialPageRoute(builder: (context) => const recipe(),))
        else
          text = "OhOh"
      }});
    return Scaffold(

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Container(child: CircularProgressIndicator(strokeWidth: 5),width: 400, height: 100 ) , Text(text),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }}
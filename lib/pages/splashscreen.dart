///
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/firstrun.dart';
import 'package:kochbuch/pages/showCategory.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
Future<bool> fr = firstrun();
String text = "Bitte warten";

  @override
  Widget build(BuildContext context) {
    fr.then((value) => {
      {
        if(value) Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  const ShowCat(),))
        else
          text = "OhOh"
      }});
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Container(width: 400, height: 100, child: const CircularProgressIndicator(strokeWidth: 5) ) , Text(text),
          ],
        ),
      ),
    );
  }}
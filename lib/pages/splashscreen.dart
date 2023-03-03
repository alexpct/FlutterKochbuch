import 'package:flutter/material.dart';
import 'package:kochbuch/helper/firstrun.dart';
import 'package:kochbuch/pages/ShowCat.dart';
//alex was here
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
        if(value) Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  ShowCat(),))
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
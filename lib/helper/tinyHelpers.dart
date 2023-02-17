import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'dart:math';

failbar(BuildContext context, String fail){

//  Alert(message:fail).show(); ... wäre nice gewesen aber aus einem mir wirklich absolut nicht nachvollziehbaren grund zeigt es mir bei jeden erdenklichen  setstate  alle möglichen fehler der reihe nach an
    return (AppBar(
      title: Text(fail),
      backgroundColor: Colors.red
    ));

}
//kann man mit Theme machen, hier kann ich aber mehr machen, ja ein observerpattern wäre hier auch angebracht, aber .... erst wenns unvermeidbar ist.
class myProps {
  static var someValue;

  static double minScreen(BuildContext context){
   return min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  }
  static double  itemSize(BuildContext context, String size){


    var val =minScreen(context);
    switch (size) {
      case "tiny": return val/10;
      case "small": return val/7;
      case "big": return val/3;
      case "huge": return val/2;
      case "fill": return val *0.9;
      default: return  val/5;
    }
  }

  static double fontSize(BuildContext context, String size) {
    var val =minScreen(context);
    switch (size) {
      case "tiny": return val/100;
      case "small": return val/20;
      case "big": return val/13;
      case "huge": return val/10;
      case "fill": return val/4;
      default: return val/16;
    }
  }
}
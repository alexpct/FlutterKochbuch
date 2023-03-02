
import 'package:flutter/material.dart';
import 'dart:math';


failbar(BuildContext context, String fail){
    return (AppBar(
      title: Text(fail),
      backgroundColor: Colors.red
    ));

}

bool isBetween(num number, num min, num max) {
  return ((min <= number  &&  max >= number));
}

class MyProps {
  static Map nutriAPI={
    'URL':'https://trackapi.nutritionix.com/v2/search/instant',
    'Headers': {
  }

  };

  static double minScreen(BuildContext context){
   return min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  }
  static double percent(BuildContext context, double percent){
    return minScreen(context)*(percent/100);
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
      case "very small": return val/50;
      case "small": return val/20;
      case "big": return val/13;
      case "huge": return val/10;
      case "fill": return val/4;
      default: return val/16;
    }
  }
}


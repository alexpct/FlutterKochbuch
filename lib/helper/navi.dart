import 'package:flutter/cupertino.dart';
import 'package:kochbuch/pages/IngredientPage.dart';
import 'package:kochbuch/pages/testpage.dart';

import '../pages/addCat.dart';
import '../pages/mIRC.dart';
import '../pages/manage.dart';
import '../pages/recipe.dart';
import '../pages/snake.dart';

void navi(context, int page){

  switch (page){
    case 0:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => SnakeGame(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 1:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  recipe(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 2: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  const Manage(), //
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
   
    case 22: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  addCat(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;

    case 23: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  mIRC(type:"category"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;

    case 24: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => mIRC(type:"ingredients"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;

    case 25: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  mIRC(type:"recipe"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    default:
  }
}
import 'package:flutter/cupertino.dart';
import 'package:kochbuch/pages/NewIngredient.dart';
import 'package:kochbuch/pages/devstart.dart';
import 'package:kochbuch/pages/newRecipe.dart';
import 'package:kochbuch/pages/testpage.dart';

import '../pages/addCat.dart';
import '../pages/mIRC.dart';
import '../pages/manage.dart';
import '../pages/recipe.dart';
import '../pages/snake.dart';
import 'objects.dart';

void navi(context, int page){

  switch (page){
    case 0:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => SnakeGame(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 5:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => newRecipe(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 4:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewIngredient(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 1:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  devStart(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 2: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewIngredient(ingredient: Ingredient(name: "Wurst", Calories: 1337, pieceGood: true,),),// mIRC(type: "category"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 21: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const mIRC(type:"categories"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    case 22: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  NewIngredient( ),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    default:
  }
}
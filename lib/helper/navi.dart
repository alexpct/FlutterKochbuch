import 'package:flutter/cupertino.dart';
import 'package:kochbuch/pages/NewIngredient.dart';
import 'package:kochbuch/pages/addCat.dart';
import 'package:kochbuch/pages/newRecipe.dart';
import 'package:kochbuch/pages/RecipeList.dart';
import 'package:kochbuch/pages/testpage.dart';

import '../pages/devstart.dart';
import '../pages/editIn.dart';
import '../pages/mIRC.dart';
import '../pages/manage.dart';
import '../pages/ShowCat.dart';
import '../pages/snake.dart';

void navi(context, int page, [String name=""]){

  switch (page){
    case 0:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => devStart(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 1:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  newRecipe(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 2: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  Manage(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 21: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ManageIRC(type:"Category"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    case 22: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  NewIngredient( ),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
        case 23: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ManageIRC(type:"Ingredients"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
         case 24: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ManageIRC(type:"Recipe"),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
        case 3: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditIn(name),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    case 4: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => Testpage(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    case 5: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => RecipeList(category: "Neu Cat",),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
         case 6: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => addCat(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    default:
  }
}
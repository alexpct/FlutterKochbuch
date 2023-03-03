import 'package:flutter/cupertino.dart';
import 'package:kochbuch/pages/NewIngredient.dart';
import 'package:kochbuch/pages/AdEdCat.dart';
import 'package:kochbuch/pages/NewRecipe.dart';
import 'package:kochbuch/pages/RecipeList.dart';
import '../pages/EditIn.dart';
import '../pages/mIRC.dart';
import '../pages/Manage.dart';
import '../pages/ShowCat.dart';
//Alex was here - ja diese missgeburt ist irgendwie entstanden und ich wollte sie nicht postnatal abtreiben
void navi(context, int page, [String name=""]){

  switch (page){
    case 0:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewRecipe(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break ;
    case 1:Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  ShowCat(),
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

    case 5: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => RecipeList(category: "Neu Cat",),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
         case 6: Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => AdEdCat(),
          transitionDuration: const Duration(seconds: 0),
        )) ; break;
    default:
  }
}
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/ShortLoadingScreen.dart';
import '../widgets/botnav.dart';

class RecipeList extends StatefulWidget {


  @override
  State<RecipeList> createState() => _RecipeListState();
}


class _RecipeListState extends State<RecipeList> {
  bool boot = true;
  String title="Rezepte";
  Map<String, Uint8List>  recipeMap;
  @override
  void initState() {
    super.initState();
    init();
  }

  init(){

  }


  @override
  Widget build(BuildContext context) {
    if (boot) return ShortLoadingScreen(title: title,index: 1,);
    Color primaryColor=Theme.of(context).primaryColor;



    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),

    ),



    bottomNavigationBar:  const BotNav(Index:1),

    body: null,);

  }
}
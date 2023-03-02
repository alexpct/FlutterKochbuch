//Alex was here
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:sqflite/sqflite.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class devStart extends StatefulWidget {


  final String title="Verwaltung";

  @override
  State<devStart> createState() => _devStartState();
}

class _devStartState extends State<devStart> {
deldb(){
  try{deleteDatabase("db.db");}catch(e){print(e);} ;
}
createdb() async {
  final database = openDatabase('db.db');
  final db = await database;


  try {
    await db.execute("CREATE TABLE Category (`Name` varchar(100) PRIMARY KEY,     `Pic` blob NOT NULL)");
  } on Exception catch (e) {
    // TODO
  }
  if (true){
    try {
      await db.execute("CREATE TABLE 'Ingredients' (`Name` varchar(100) PRIMARY KEY, 'Calories' REAL, 'Fat' REAL, 'Protein' REAL, 'Carbohydrates' REAL, 'pieceGood' BOOLEAN, 'weight' REAL, `bytes` blob NOT NULL)");
    } on Exception catch (e) {
      // TODO
    }
  }
  if(true){
    try{await db.execute("CREATE TABLE recipe (`Name` varchar(100) PRIMARY KEY,    'text' text, 'time' integer , 'category' text)");}catch(e){print(e);};
    try{await db.execute("CREATE TABLE recipeIngredients ('recipe' text,    'ingredient' text, 'quantity' integer )");}catch(e){print(e);};
    try{await db.execute("CREATE TABLE recipePics ('recipe' text,    `bytes` blob NOT NULL  )");}catch(e){print(e);};
    try{await db.execute("CREATE TABLE recipeCats ('recipe' text,   'cats' text  )");}catch(e){print(e);};

  }
}
dbHelper db = dbHelper();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        bottomNavigationBar:  BotNav(Index:2),
        body: Center(
          child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                ElevatedButton(onPressed:()=>{ navi(context, 1)}, child: Text("Navi1")),
                ElevatedButton(onPressed:()=>{ navi(context, 2)}, child: Text("Navi2")),
                ElevatedButton(onPressed:()=>{ navi(context, 3,"ei")}, child: Text("Navi3")),
                ElevatedButton(onPressed:()=>{ navi(context, 4)}, child: Text("Navi4")),
                ElevatedButton(onPressed:()=>{ navi(context, 5)}, child: Text("Navi5")),
                Container(height: 100,),
                ElevatedButton(onPressed:deldb, child: Text("Delete database")),
                ElevatedButton(onPressed:createdb, child: Text("Create DB")),


              ]),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

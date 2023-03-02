import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/pages/recipe.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  var _db;
  String resultType = "None";
  var result;

  dbHelper(){open();}

  open() async {
      final database = openDatabase('db.db');
      _db = await database;
  }

   Future<String>newRecipe(String name, File image) async {
     Uint8List bytes;
    try{bytes = await image.readAsBytes();} catch(e){return Future<String>.value("Dieser Fehler sollte nicht vorkommen");}
    var val = {'Name': name,
      'Pic': bytes};
    try { await _db.insert("Category", val );} catch(e){return Future<String>.value("Kategorie schon vorhanden");}
    return Future<String>.value("OK");

  }


  getCat([String startsWith]) async {
    resultType ="Cat";
    await open();
    String q = "select * from Category";
    if(startsWith!=null) print(startsWith);
    if(startsWith!=null)q+="where name LIKE '$startsWith%'";
    result = await _db.rawQuery("select * from Category");
    print(result.runtimeType);
    return result;
  }

 Future<List<Ingredient>>getIng([String name]) async {
    await open();
    List<Ingredient> list=[];
    String query = "Select * from 'Ingredients' ";
    if(name!=null) query +=" where name='$name'";
    result = await _db.rawQuery(query);

    for (var i=0; i<result.length ; i++ ){

      var e = result[i];
      bool whyTheFuckIsntThatWorkingInline = e['pieceGood']==0? false : true;
      list.add(Ingredient(name: e['Name'], Calories: e['Calories'], pieceGood:whyTheFuckIsntThatWorkingInline,Fat: e['Fat'],Carbohydrates: e['Carbohydrates'], Protein:e['Protein'], bytes: e['bytes'], weight: e['weight']  ));

    }
    return  Future<List<Ingredient>>.value(list);

  }

  getAll(String tablename) async {
    resultType =tablename;
    await open();
    result = await _db.rawQuery("select * from $tablename");
  }



  void dispose(){
    try{_db.close();} catch(e){};
  }


  Future<List<String>>getName(String typ) async{
    resultType ="Cat";
    await open();
    result = await _db.rawQuery("select Name from "+typ);
    List<String> list=[];
//    print(result.toString());
    for (var i=0;i<result.length;i++){
     list.add(result[i]['Name']);
    }
    return Future<List<String>>.value(list);
  }

  getEntry(String table, String name) async{
    await open();
    result = await _db.rawQuery("select * from "+table+" where name = '"+name+"'");
    //print(result);
  }

  deleteentry(String name, String tabel) async{
    await open();
    await _db.rawQuery("delete from "+ name +" where name = '"+tabel+"'");
  }

  insertDBZ(String Name , Uint8List bytes, double Calories , double Fat , double Protein, double Carbohydrates, bool pieceGood, double weight, String table ) async{

    await open();
    result= await _db.rawQuery("INSERT INTO $table ( Name , bytes , Calories , Fat , Protein , Carbohydrates , piecegood , weight ) VALUES ( '$Name', '$bytes' , '$Calories' , '$Fat' , '$Protein' , '$Carbohydrates' , '$pieceGood' , '$weight' )");
    //print(result);
  }
Future<Recipe> getRecipe(String Name) async {
    await open();
  var recipe = await  _db.rawQuery("select * from 'recipe' where Name = '"+Name+"'");
print(recipe);
  String Text =  recipe[0]['text'];
  int Time =  recipe[0]['time'];

  List<Ingredient> ingredients=[];
  var recipeIngredients =  await  _db.rawQuery("select * from 'recipeIngredients' where recipe = '"+Name+"'");
  for(var i=0; i<recipeIngredients.length;i++){
    Ingredient ing;
    await getIng(recipeIngredients[i]['ingredient']).then((value) => ing=value.first);
    ing.quantity=recipeIngredients[i]['quantity'];
    ingredients.add(ing);

  }
  List<String> cats=[];
  var recipeCats =  await  _db.rawQuery("select * from 'recipeCats' where recipe = '"+Name+"'");
  recipeCats.forEach((e)=>cats.add(e['cats']));


  List<Uint8List> images= <Uint8List>[];
  var recipePics =  await  _db.rawQuery("select * from 'recipePics' where recipe = '"+Name+"'");
  recipePics.forEach((e)=>images.add(e['bytes']));

Recipe ret=Recipe(Name: Name, Text: Text,ingredients: ingredients, Time: Time, cats: cats, images: images);
return Future.value(ret);

}

deleteRecipe(String Name) async {//weiß grad nicht ob sqlite inner joins kann bzw on delete cascade, denke ja, aber das lite lässt mich stutzen , also was du nicht im kopf hast, das hast du in bei... ähm fingern
  await _db.rawQuery("delete from recipe  where name = '"+Name+"'");
  await _db.rawQuery("delete from recipeIngredients  where recipe = '"+Name+"'");
  await _db.rawQuery("delete from recipePics  where recipe = '"+Name+"'");
  await _db.rawQuery("delete from recipeCats  where recipe = '"+Name+"'");

}
}
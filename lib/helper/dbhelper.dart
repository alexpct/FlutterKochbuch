 ///
import 'dart:io';
import 'dart:typed_data';

import 'package:kochbuch/helper/objects.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  var _db;
  String resultType = "None";
  var result;

  DbHelper(){open();}

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
      list.add(Ingredient(name: e['Name'], calories: e['Calories'], pieceGood:whyTheFuckIsntThatWorkingInline,fat: e['Fat'],carbohydrates: e['Carbohydrates'], protein:e['Protein'], bytes: e['bytes'], weight: e['weight']  ));

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
    result = await _db.rawQuery("select Name from $typ");
    List<String> list=[];
    for (var i=0;i<result.length;i++){
     list.add(result[i]['Name']);
    }
    return Future<List<String>>.value(list);
  }

  getEntry(String table, String name) async{
    await open();
    result = await _db.rawQuery("select * from $table where name = '$name'");
  }

  deleteentry( String table,String name,) async{
    await open();
    await _db.rawQuery("delete from $table where name = '$name'");
  }

  insertCatDBZ(String name , Uint8List bytes, String table ) async{

    await open();
    result= await _db.rawQuery("INSERT INTO $table ( Name , Pic ) VALUES ( '$name', '$bytes')");
  }
 Future<Recipe> getRecipe(String name) async {
  await open();
  var recipe = await  _db.rawQuery("select * from 'recipe' where Name = '$name'");
  String text =  recipe[0]['text'];
  int time =  recipe[0]['time'];

  List<Ingredient> ingredients=[];
  var recipeIngredients =  await  _db.rawQuery("select * from 'recipeIngredients' where recipe = '$name'");
  for(var i=0; i<recipeIngredients.length;i++){
    Ingredient ing;
    await getIng(recipeIngredients[i]['ingredient']).then((value) => ing=value.first);
    ing.quantity=recipeIngredients[i]['quantity'];
    ingredients.add(ing);

  }
  List<String> cats=[];
  var recipeCats =  await  _db.rawQuery("select * from 'recipeCats' where recipe = '$name'");
  recipeCats.forEach((e)=>cats.add(e['cats']));


  List<Uint8List> images= <Uint8List>[];
  var recipePics =  await  _db.rawQuery("select * from 'recipePics' where recipe = '$name'");
  recipePics.forEach((e)=>images.add(e['bytes']));

  Recipe ret=Recipe(name: name, text: text,ingredients: ingredients, time: time, cats: cats, images: images);
  return Future.value(ret);

 }

 deleteRecipe(String name) async {
  await _db.rawQuery("delete from recipe  where name = '$name'");
  await _db.rawQuery("delete from recipeIngredients  where recipe = '$name'");
  await _db.rawQuery("delete from recipePics  where recipe = '$name'");
  await _db.rawQuery("delete from recipeCats  where recipe = '$name'");

 }
}
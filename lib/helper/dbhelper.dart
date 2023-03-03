import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:kochbuch/helper/objects.dart';
import 'package:sqflite/sqflite.dart';


//Alex: Soll alle DatenbankFunktionen übernehmen, die nicht das Objekt selbst
// betreffen(das kann sich selbst in die DB schreiben - inkohärent und mies zu warten, wird noch ausgebessert)
//Wenn nicht anders angegeben von Alex
class DbHelper {
  var _db;
  String resultType = "None";
  var result;

  DbHelper(){open();} //mag dart so nicht, ist auch gegen die Wand gefahren sobald kein "Nutzerdelay" dazwischen war, aber um nichts zu refactorn wurde es drin gelassen

  open() async {
      final database = openDatabase('db.db');
      _db = await database;
  }

  // hier wurde noch nicht mit den objekten gearbeitet, aber never touch a running system  :D
   Future<String>newCategory(String name, File image) async {
     Uint8List bytes;
    try{bytes = await image.readAsBytes();} catch(e){return Future<String>.value("Dieser Fehler sollte nicht vorkommen");}
    var val = {'Name': name,
      'Pic': bytes};
    try { await _db.insert("Category", val );} catch(e){return Future<String>.value("Kategorie schon vorhanden");}
    return Future<String>.value("OK");

  }


  getCat([String startsWith]) async {
    await open();
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
 //Susi start
  getAll(String tablename) async {
    resultType =tablename;
    await open();
    result = await _db.rawQuery("select * from $tablename");
  }
//Susi end




  void dispose(){
    try{_db.close();} catch(e){};
  }





//Susi start
  Future<List<String>>getName(String typ) async{
    resultType ="Cat";
    await open();
    result = await _db.rawQuery("select Name from "+typ);
    List<String> list=[];
    for (var i=0;i<result.length;i++){
     list.add(result[i]['Name']);
    }
    return Future<List<String>>.value(list);
  }

  getEntry(String table, String name) async{
    await open();
    result = await _db.rawQuery("select * from "+table+" where name = '"+name+"'");
  }

  deleteentry(String name, String tabel) async{
    await open();
    await _db.rawQuery("delete from "+ name +" where name = '"+tabel+"'");
  }

  insertDBZ(String Name , Uint8List bytes, double Calories , double Fat , double Protein, double Carbohydrates, bool pieceGood, double weight, String table ) async{

    await open();
    result= await _db.rawQuery("INSERT INTO $table ( Name , bytes , Calories , Fat , Protein , Carbohydrates , piecegood , weight ) VALUES ( '$Name', '$bytes' , '$Calories' , '$Fat' , '$Protein' , '$Carbohydrates' , '$pieceGood' , '$weight' )");
  }

  //susi end




Future<Recipe> getRecipe(String Name) async {
  await open();
  var recipe = await  _db.rawQuery("select * from 'recipe' where Name = '"+Name+"'");
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

Recipe ret=Recipe(name: Name, text: Text,ingredients: ingredients, time: Time, cats: cats, images: images);
return Future.value(ret);

}

deleteRecipe(String Name) async {//weiß grad nicht ob sqlite inner joins kann bzw on delete cascade, denke ja, aber das lite lässt mich stutzen , also was du nicht im kopf hast, das hast du in bei... ähm fingern
  await open();
  await _db.rawQuery("delete from recipe  where name = '"+Name+"'");
  await _db.rawQuery("delete from recipeIngredients  where recipe = '"+Name+"'");
  await _db.rawQuery("delete from recipePics  where recipe = '"+Name+"'");
  await _db.rawQuery("delete from recipeCats  where recipe = '"+Name+"'");

}
Future<List<Recipe>>getCatsRecipe(String category) async {
    await open();

  var recipeCats =  await  _db.rawQuery("select * from 'recipeCats' where cats = '"+category+"'");
  List<String> recipe=[];
  recipeCats.forEach((e)=>recipe.add(e['recipe']));
  recipe=recipe.toSet().toList();
  if(recipe.isEmpty) return Future<List<Recipe>>.value(<Recipe>[]);
  List<Recipe> list=[];
   await Future.wait([for(var i=0; i<recipe.length;i++)
getRecipe(recipe[i]).then((value) => list.add(value))]);


  return  Future<List<Recipe>>.value(list);
  
  




}

}
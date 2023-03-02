

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/pages/recipe.dart';
import 'package:sqflite/sqflite.dart';

Future<Cat>catFromFile(String name, File file) async {
  Uint8List bytes = await file.readAsBytes();
//await toBytes(file).then((value) => bytes=value);
return Future<Cat>.value(Cat(name: name, bytes: bytes));
}
class Cat
{
  String name;
  Uint8List  bytes;
  Image image; //jup das verdoppelt den ramverbrauch, ist  mir bewusst, aber wer solche frameworks benutzt dem ist ram egal

  Cat({this.name, this.bytes}) {

    image = Image.memory(bytes);
  }

  Future<String> save([bool update]) async {
    final database = openDatabase('db.db');
    var db = await database;
    var val = {'Name': name,
      'Pic': bytes};
    if(update!=null && update){ await db.update("Category", val ); return Future<String>.value("OK"); }
    try { await db.insert("Category", val );} catch(e){return Future<String>.value("Kategorie schon vorhanden");}
    return Future<String>.value("OK");

  }



}


class Ingredient {
double Calories;
double Fat;
double Protein;
double Carbohydrates;
Uint8List  bytes;
Image image;
String name;
bool pieceGood;
double weight;
int quantity=0;

Ingredient({ this.name, this.Calories,this.bytes, this.Carbohydrates=-1, this.Fat=-1, this.Protein=-1, this.pieceGood, this.weight=-1}){
if (bytes!=null)  image = Image.memory(bytes); // auch mit einem nullcheck davor will der compiler den nullcheck -.-
}

save() async {
  final database = openDatabase('db.db');
  var db = await database;
  var val = {'Name': name,
    'bytes': bytes,
    'calories': Calories,
  'Fat' : Fat ,
   'Protein': Protein,
  'Carbohydrates': Carbohydrates,
    'PieceGood': pieceGood,
  'weight':weight};
   await db.insert("Ingredients", val );//} catch(e){ try { await db.delete("Ingredients", where: "name=${val['name']}" ); db.insert("Ingredients", val );} catch(ee){print(ee);}}

}


}

class Recipe{

  String Name;
  String Text;
  int Time=0;
  List<String> cats=[];
  List<Ingredient> ingredients=[];
  List<Uint8List> images= <Uint8List>[];


  Recipe({this.Text="",this.cats,this.images,this.ingredients,this.Name="Name",this.Time=0,}){
    images??=  <Uint8List>[];
    cats??=  <String>[];
    ingredients??=<Ingredient>[];
  }

  Future<String> save(bool update,[String oldName]) async {
  final database = openDatabase('db.db');
  var db = await database;
  dbHelper dbH = dbHelper(); //codesmell den du so weit riechen kannst das kein längenmaß  es abbilden kann.
  oldName??= Name;
  if (Name=="Name"||Name=="") return Future<String>.value("Namen eingeben!");
  if (Text.length<3) return Future<String>.value( "Beschreibung hinzufügen!");
  if (cats.isEmpty)  return Future<String>.value( "Mindestens eine Kategorie angeben!");
 if(update) await dbH.deleteRecipe(oldName); // dampfhammer methode, aber geht so schön schnell
var val ={
  'Name': Name,
  'text': Text,
  'time': Time,
};
 try {
   db.insert("recipe", val );
 } on Exception catch (e) {
   return  Future<String>.value("Name/Rezept schon Vorhanden"); }

for(var i=0; i<ingredients.length && ingredients.isNotEmpty ;i++){
  var val = {'recipe':Name,
  'ingredient':ingredients[i].name,
    'quantity':ingredients[i].quantity
  };
   db.insert("recipeIngredients", val );
}

 for(var i=0; i<cats.length;i++){
    var val = {'recipe':Name,
      'cats':cats[i]
    };
    db.insert("recipeCats", val );
  }

  for(var i=0; i<images.length;i++){
    var val = {'recipe':Name,
      'bytes':images[i]
    };
    db.insert("recipePics", val );
  }



}


}
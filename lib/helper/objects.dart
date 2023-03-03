///

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

//Alex was here
//die saveFunktion hätte in die DB klasse gehört, wird noch gemacht
//Ansosten eben Objekte um sie kompakter übergeben zu können
//Category heißt immer Cat weil hier jemand Katzen mag xD

class Cat
{
  String name;
  Uint8List  bytes;
  Image image; 

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

Future<Cat>catFromFile(String name, File file) async {
  Uint8List bytes = await file.readAsBytes();
return Future<Cat>.value(Cat(name: name, bytes: bytes));
}


class Ingredient {
  double calories;
  double fat;
  double protein;
  double carbohydrates;
  Uint8List  bytes;
  Image image;
  String name;
  bool pieceGood;
  double weight;
  int quantity=0;

  Ingredient({ this.name, this.calories,this.bytes, this.carbohydrates=-1, this.fat=-1, this.protein=-1, this.pieceGood, this.weight=-1}){
    if (bytes!=null)  image = Image.memory(bytes); 
  }

  save() async {
    final database = openDatabase('db.db');
    var db = await database;
    var val = {'Name': name,
      'bytes': bytes,
      'calories': calories,
    'Fat' : fat ,
    'Protein': protein,
    'Carbohydrates': carbohydrates,
      'PieceGood': pieceGood,
    'weight':weight};
    await db.insert("Ingredients", val );//} catch(e){ try { await db.delete("Ingredients", where: "name=${val['name']}" ); db.insert("Ingredients", val );} catch(ee){print(ee);}}

  }

}

class Recipe{

  String name;
  String text;
  int time=0;
  List<String> cats=[];
  List<Ingredient> ingredients=[];
  List<Uint8List> images= <Uint8List>[];


  Recipe({this.text="",this.cats,this.images,this.ingredients,this.name="Name",this.time=0,}){
    images??=  <Uint8List>[];
    cats??=  <String>[];
    ingredients??=<Ingredient>[];
  }

  Future<String> save(bool update,[String oldName]) async {
    final database = openDatabase('db.db');
    var db = await database;
    DbHelper dbH = DbHelper();
    oldName??= name;
    if (name=="Name"||name=="") return Future<String>.value("Namen eingeben!");
    if (text.length<3) return Future<String>.value( "Beschreibung hinzufügen!");
    if (cats.isEmpty)  return Future<String>.value( "Mindestens eine Kategorie angeben!");
    if(update) await dbH.deleteRecipe(oldName); 
    var val ={
      'Name': name,
      'text': text,
      'time': time,
    };
    try {
      db.insert("recipe", val );
    } on Exception catch (e) {
      return  Future<String>.value("Name/Rezept schon Vorhanden"); }

    for(var i=0; i<ingredients.length && ingredients.isNotEmpty ;i++){
      var val = {'recipe':name,
      'ingredient':ingredients[i].name,
        'quantity':ingredients[i].quantity
      };
      db.insert("recipeIngredients", val );
    }

    for(var i=0; i<cats.length;i++){
        var val = {'recipe':name,
          'cats':cats[i]
        };
        db.insert("recipeCats", val );
      }

    for(var i=0; i<images.length;i++){
      var val = {'recipe':name,
        'bytes':images[i]
      };
      db.insert("recipePics", val );
    }
 }
}
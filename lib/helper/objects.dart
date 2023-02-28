

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
    'pieceGood': pieceGood,
  'weight':weight};
   await db.insert("Ingredients", val );//} catch(e){ try { await db.delete("Ingredients", where: "name=${val['name']}" ); db.insert("Ingredients", val );} catch(ee){print(ee);}}

}


}
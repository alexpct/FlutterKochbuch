

import 'dart:convert';
import 'dart:io';
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
  late Uint8List  bytes;
  Image? image;

  Cat({required this.name, required this.bytes}) {

    image = Image.memory(bytes);
  }

  Future<String> save([bool? update]) async {
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
double Calories=0;
double Fat=0;
double Protein=0;




}
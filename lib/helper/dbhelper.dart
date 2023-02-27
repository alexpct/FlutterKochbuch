import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:kochbuch/helper/objects.dart';
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
    final Uint8List bytes;
    try{bytes = await image.readAsBytes();} catch(e){return Future<String>.value("Dieser Fehler sollte nicht vorkommen");}
    var val = {'Name': name,
      'Pic': bytes};
    try { await _db.insert("Category", val );} catch(e){return Future<String>.value("Kategorie schon vorhanden");}
    return Future<String>.value("OK");

  }


  getCat() async {
    resultType ="Cat";
    await open();
    result = await _db.rawQuery("select * from Category");
  }

  getIng([String? name]){
    List<Ingredient> list=[];
    String query = "Select * from 'ingredients' ";
    if(name!=null) query +=" where name='$name'";
    result = _db.rawQuery(query);


  }

  getAll(String tablename) async {
    resultType =tablename;
    await open();
    result = await _db.rawQuery("select * from $tablename");
  }



  void dispose(){
    try{_db.close();} catch(e){};
  }


  getsomething(String typ) async{
    resultType ="Cat";
    await open();
    result = await _db.rawQuery("select Name from "+typ);
    print(result);
  }

  deleteentry(String name, String typ) async{
    await open();
    await _db.rawQuery("delete from "+ name +" where name = '"+typ+"'");
  }

}
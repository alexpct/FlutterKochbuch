import 'dart:convert';
import 'dart:io';
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

   newRecipe(String name, File image) async {
    final bytes = await image.readAsBytes();

     var check =await _db.rawQuery("Select Name from Category where name='"+name+"'");
if (check.length>0) return false;

    //html.Blob blobs = html.Blob(image.readAsBytesSync());
    var val = {     'Name': name,
      'Pic': bytes};
    await _db.insert("Category", val );
    
    

return true;
  }
  getCat() async {
    if(_db==null) return false;
    resultType ="Cat";
    result = await _db.rawQuery("select * from Category");
  }



  void dispose(){
    try{_db.close();} catch(e){};
  }

}
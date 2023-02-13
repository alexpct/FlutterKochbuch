import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


// jup haben wir sicher anders gelernt ... sorry


  Future<bool> firstrun()  async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
   await  Future.delayed(const Duration(seconds: 2));
    prefs.setBool('initialized', false ); // entfern mich du depp
    if(prefs.getBool('initialized')??false) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => recipe(),));

      return Future<bool>.value(true);
    }  else {
       try{

         final database = openDatabase('db.db');
         final db = await database;

         try{await db.execute("DROP TABLE 'Category' ");     } catch(e){};
        await db.execute("CREATE TABLE Category (`Name` varchar(100) PRIMARY KEY,     `Pic` blob NOT NULL)");
         await db.execute("INSERT INTO Category (name, pic) values ('wurst', 'ff')");
        
        prefs.setBool('initialized', true );
        return Future<bool>.value(true);
      } catch(e) {return Future<bool>.value(false);}
    }

  }

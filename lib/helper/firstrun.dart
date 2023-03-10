    ///
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

  Future<bool> firstrun()  async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
   await  Future.delayed(const Duration(seconds: 2));
    prefs.setBool('initialized', false );
    if(prefs.getBool('initialized')??false) {
      return Future<bool>.value(true);
    }  else {
       try{

         final database = openDatabase('db.db');
         final db = await database;

        if(true){ try{await db.execute("DROP TABLE 'Category' ");     } catch(e){};
        await db.execute("CREATE TABLE Category (`Name` varchar(100) PRIMARY KEY,     `Pic` blob NOT NULL)");
        }
        if (!true){
          try{await db.execute("DROP TABLE 'Ingredients' ");}catch(e){print (e);}
          await db.execute("CREATE TABLE 'Ingredients' (`Name` varchar(100) PRIMARY KEY, 'Calories' REAL, 'Fat' REAL, 'Protein' REAL, 'Carbohydrates' REAL, 'pieceGood' BOOLEAN, 'weight' REAL, `bytes` blob NOT NULL)");
        }
        if(true){
          try{await db.execute("CREATE TABLE recipe (`Name` varchar(100) PRIMARY KEY,    'text' text, 'time' integer )");}catch(e){};
          try{await db.execute("CREATE TABLE recipeIngredients ('recipe' text,    'ingredient' text, 'quantity' integer )");}catch(e){};
          try{await db.execute("CREATE TABLE recipePics ('recipe' text,    `bytes` blob NOT NULL  )");}catch(e){};

        }
  
        prefs.setBool('initialized', true );
        return Future<bool>.value(true);
      } catch(e) {return Future<bool>.value(false);}
    }

  }

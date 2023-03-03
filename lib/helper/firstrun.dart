///
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future<bool> firstrun() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(seconds: 2));
  if (prefs.getBool('initialized') ?? false) {
    return Future<bool>.value(true);
  } else {
    try {
      final database = openDatabase('db.db');
      final db = await database;

      await db.execute(
          "CREATE TABLE Category (`Name` varchar(100) PRIMARY KEY,     `Pic` blob NOT NULL)");

      await db.execute(
          "CREATE TABLE 'Ingredients' (`Name` varchar(100) PRIMARY KEY, 'Calories' REAL, 'Fat' REAL, 'Protein' REAL, 'Carbohydrates' REAL, 'pieceGood' BOOLEAN, 'weight' REAL, `bytes` blob NOT NULL)");

      await db.execute(
          "CREATE TABLE recipe (`Name` varchar(100) PRIMARY KEY,    'text' text, 'time' integer , 'category' text)");
      await db.execute(
          "CREATE TABLE recipeIngredients ('recipe' text,    'ingredient' text, 'quantity' integer )");
      await db.execute(
          "CREATE TABLE recipePics ('recipe' text,    `bytes` blob NOT NULL  )");
      await db
          .execute("CREATE TABLE recipeCats ('recipe' text,   'cats' text  )");
      prefs.setBool('initialized', true);
      return Future<bool>.value(true);
    } catch (e) {
      return Future<bool>.value(false);
    }
  }
}


import 'dart:ffi';
import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/pages/showRecipe.dart';

import '../helper/objects.dart';
import '../helper/tinyHelpers.dart';
import '../widgets/ShortLoadingScreen.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

//Alex was here - einfach ne Auflistung aller Rezepte in der Kategorie
class RecipeList extends StatefulWidget {
  RecipeList({this.category});
String category;

  @override
  State<RecipeList> createState() => _RecipeListState();
}


class _RecipeListState extends State<RecipeList> {
  bool boot = true;
  String title="Rezepte";
  List<Recipe> recipes=[];
  List<Recipe> unFiltered=[];
  dbHelper db = dbHelper();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {


 db.getCatsRecipe(widget.category)
     .then((value) =>recipes=value)
     .then((value) =>  unFiltered = List.from(recipes))
     .then((value) => setState(() {   boot=false; }));







  }
  filter(String text){
    setState(() {
      recipes = unFiltered.where((element) => element.name.toLowerCase().contains(text.toLowerCase())).toList();

    });
  }

  open(int index){
    Navigator.push(
    context,
    PageRouteBuilder(
    pageBuilder: (_, __, ___) =>  ShowRecipe(recipe: recipes[index],),
    transitionDuration: const Duration(seconds: 0),
    )) ;

  }



  @override
  Widget build(BuildContext context) {
    if (boot) return ShortLoadingScreen(title: title,index: 1,);
    Color primaryColor=Theme.of(context).primaryColor;


print(recipes);
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),

    ),



    bottomNavigationBar:  const BotNav(Index:1),

    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:  EdgeInsets.all(MyProps.percent(context, 2)),
          child: GridView.builder( //Builder für das Kategorien Layout
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: MyProps.percent(context, 2),
                mainAxisSpacing: MyProps.percent(context, 2),

              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {

                final item = recipes[index];
                var img;
                print("ölapalöma");
                (item.images.isEmpty)? img=null : img=Image.memory(item.images.first);
                return ImgBox(label: item.name, onTap: () =>open(index), image: img ,size: MyProps.itemSize(context, "normal"),noMargin: true,); //Bilder der Kategorien
              }
          ),
        ),


        Padding(
          padding:  EdgeInsets.all(MyProps.percent(context, 2)),
          child: TextFormField( //Textfield der Suche
              onChanged: (text) {
                filter(text);},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Suche',
              )),
        ),

      ],
    ),);

  }
}
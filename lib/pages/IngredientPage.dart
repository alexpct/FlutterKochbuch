//Alex was here
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/NutriAPI.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';

import '../helper/dbhelper.dart';
import '../widgets/botnav.dart';

class IngredientPage extends StatefulWidget {
  IngredientPage({super.key,});


  final String title = "Zutat hinzufügen";
  final db = dbHelper();

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  NutriAPI nutriAPI= NutriAPI();
  List<Ingredient> IList=[];
  Ingredient? ing;

  onTap(Ingredient ingredient){
    ing=ingredient;
}
enterEdit(){}
  textChange(String text) async {
   setState(() {
     wid=Container(margin: EdgeInsets.only(top: myProps.percent(context, 20)),width:myProps.itemSize(context, "huge"),height:myProps.itemSize(context, "big") ,child: CircularProgressIndicator());
   });
    if (text.length<2) return null;

    IList = await nutriAPI.search(text);
    if(IList.length<1) {enterEdit();return null;}
    List<Widget> list= [];

    for(var i=0; i<IList.length;i++){
      list.add(
          Container(child: IngredientWidget(ingredient: IList[i], onTap:(){}))

      );
    }

    setState(() {
      wid=Expanded(child: ListView(children: list,));

    });

  }
  Widget wid=Container( height: 100 ,width:200,color: Colors.red);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar:  BotNav(Index:1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(myProps.percent(context, 1), myProps.percent(context, 3), myProps.percent(context, 1), myProps.percent(context, 1)),
        child: TextField(
          onChanged: (text){textChange(text); },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Zutat suchen'),

          ),
        )),
        wid,
          ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

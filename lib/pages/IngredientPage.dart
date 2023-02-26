//Alex was here
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/NutriAPI.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/main.dart';
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
  Ingredient ingredient=Ingredient(name: "Name", Calories: 0, pieceGood: true,);
  bool? isChecked=false;
  _IngredientPageState(){

  }

 onTap(value){
  ingredient=value;
  print(value);
setState(() {
  enterEdit();
});

}


enterEdit(){

   wid=Container(
     child: Expanded(
       child:  Padding(
         padding:  EdgeInsets.all(myProps.percent(context, 3)),
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [Text("Stückware?") ,Checkbox(
             checkColor: Colors.white,
             value: isChecked,
             onChanged: (bool? value) {
               setState(() {
                 isChecked = value!;
                 enterEdit();}
               );})]),
               Padding(
                 padding:  EdgeInsets.all(myProps.percent(context, 5)),
                 child: Row(
  children: [Text("Nährwerte pro 100g/Stück"),]
                 )
               ),

               Table(
                   columnWidths:   <int, TableColumnWidth>{ // susi: hier dann auf 4 spalten gehen bzw 5 mit einer leeren Spalte dazwischen
                     2: FixedColumnWidth(myProps.percent(context, 10)),
                     1: FixedColumnWidth(myProps.percent(context, 30)),
                     0: FlexColumnWidth()
                   },
                   children:<TableRow>[
                     TableRow(
                         children: <Widget>[Text("Name",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.name) , Text(""),
                         ]
                     ),
                     TableRow(
                         children: <Widget>[Text("Kalorien",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Calories.toString()) , Text("kcal"),
                         ]
                     ),
                     TableRow(
                         children: <Widget>[Text("Kohlenhydrate",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Carbohydrates.toString()) , Text("g"),
                         ]
                     ),
                     TableRow(
                         children: <Widget>[Text("Fett",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Fat.toString()) , Text("g"),
                         ]
                     ),

                     TableRow(
                         children: <Widget>[Text("Eiweiß",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Protein.toString()) , Text("g"),
                         ]
                     ),


                   ]
               ),
             ],
           ),
         ),
       ),
     ),
   );

setState(() {

});
}

  textChange(String text, int delay) async {

   setState(() {
     wid=Container(margin: EdgeInsets.only(top: myProps.percent(context, 20)),width:myProps.itemSize(context, "huge"),height:myProps.itemSize(context, "big") ,child: CircularProgressIndicator());
   });
    if (text.length<2) {enterEdit();return null;}
    await new Future.delayed( Duration(microseconds: delay));


    IList = await nutriAPI.search(text);
    if(IList.isEmpty) {enterEdit();return null;}
    List<Widget> list= [];

    for(var i=0; i<IList.length;i++){
      list.add(
          Container(child: IngredientWidget(ingredient: IList[i], onTap:(value)=>{onTap(value)}))

      );
    }

    setState(() {
      wid=Expanded(child: ListView(children: list,));

    });

  }
  Widget? wid;

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
          onChanged: (text){textChange(text,500);},
          onSubmitted:  (text){textChange(text,1);},

          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Zutat suchen'),

          ),
        )),
        wid?? Padding(padding:EdgeInsets.fromLTRB(0, myProps.percent(context, 40), 0, 0),  child: ElevatedButton(onPressed: enterEdit, child: Text("Manuell hinzufügen!"))),
          ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

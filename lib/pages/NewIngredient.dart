//Alex was here
import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:kochbuch/helper/NutriAPI.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/main.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';
import 'package:flutter/services.dart';

import '../helper/dbhelper.dart';
import '../helper/imagepicker.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';


class NewIngredient extends StatefulWidget {

  final String title = "Zutat hinzufügen";
  final db = dbHelper();
  Ingredient ingredient=Ingredient(name: "Name", Calories: 0, pieceGood: true,);

  @override
  State<NewIngredient> createState() => _NewIngredientState();
}

class _NewIngredientState extends State<NewIngredient> {
  NutriAPI nutriAPI= NutriAPI();
  List<Ingredient> IList=[];
  Ingredient ingredient;
  bool isChecked=false;

 onTap(value){
  ingredient=value;
setState(() {
  enterEdit();
});

}

  getImg(bool useCamera) async {
    var _image;
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
      _image  = value;
    })).then((a) => ingredient.image=Image.file(_image))
        .then((value) async => ingredient.bytes= await _image.readAsBytes())
        .then((value) => enterEdit());



  }
  save(){ingredient.save();Navigator.pop(context);}

  _nameUpdate(String a){ingredient.name=a; enterEdit();print("dingdong");}
enterEdit(){
   ingredient ??= widget.ingredient;
   wid=Expanded(
     child:  SingleChildScrollView(
       child: Column(
         children: [
           Padding(
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
                 onChanged: (bool value) {
                   setState(() {

                     isChecked = value;
                     ingredient.pieceGood= isChecked;
                     enterEdit();}
                   );})]),
                   Padding(
                     padding:  EdgeInsets.all(myProps.percent(context, 5)),
                     child: Row(
  children: [Text("Nährwerte pro 100g/Stück"), ImgBox(
    label: ingredient.name,
    onTap: () => {getImg(false)},
    size: myProps.itemSize(context, "small"),
    image: ingredient.image,
    //file: _image,
    fontSize: myProps.fontSize(context, "big"),
  ),]
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
                             children: <Widget>[Text("Name",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.name,
                             onFieldSubmitted:(a)=>{_nameUpdate(a)},onTap: enterEdit,) , Text(""),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kalorien",style:   TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Calories.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Calories=double.parse(value)}},keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]) , Text("kcal"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kohlenhydrate",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Carbohydrates.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Carbohydrates=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Fett",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Fat.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Fat=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),  Text("g"),
                             ]
                         ),

                         TableRow(
                             children: <Widget>[Text("Eiweiß",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Protein.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Protein=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Gewicht:",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.weight.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.weight=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),


                       ]
                   ),
                   Padding(
                     padding:  EdgeInsets.all(myProps.percent(context, 5)),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         ElevatedButton(
                             onPressed: () => {getImg(false)},
                             child: Text("Bild hochladen"),
                             style: ButtonStyle(
                                 shape:
                                 MaterialStateProperty.all<RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(18.0))))),
                         SizedBox(width: myProps.itemSize(context, "medium")),
                         Ink(
                           decoration: ShapeDecoration(
                             color: Theme.of(context).colorScheme.primary,
                             shape: CircleBorder(),
                           ),
                           child: IconButton(
                             icon: const Icon(Icons.add_a_photo),
                             onPressed: () => { getImg(true)},
                           ),
                         ),
                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       ElevatedButton(onPressed: save, child: Text("Zutat hinzufügen"))
                     ],
                   )
                 ],
               ),
             ),
           ),
         ],
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
  Widget wid;

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

//Susann was here  ///

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/navi.dart';

import 'dart:io';

import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/widgets/iconbox.dart';
import 'package:flutter/services.dart';

import '../helper/imagepicker.dart';
import '../helper/objects.dart';

class EditIn extends StatefulWidget {
   const EditIn( this.edible, {Key key}) : super(key: key);

  final String edible;
  @override
  _EditInState createState() => _EditInState();
}

class _EditInState extends State<EditIn> {
  Future myFuture;  
  DbHelper db = DbHelper();
  String name = "Name"; 
  String fail = "OK";
  Image pictureEdit; // Bild für Anzeige in ImgeBox
  bool isChecked=false; //Checkbox value
  List<Map<String, dynamic>>dbEntries=[]; //Liste für DB entry
  Ingredient ingredient=Ingredient(name: "Name", calories: 0, pieceGood: true,); //Zutaten Klasse


  getImg(bool useCamera) {
   Future<File> ip = imgPicker(useCamera);
   ip.then((value) => value.readAsBytes().then((value) => ingredient.bytes=value).then((value) => setState(() {  
          },))
    );
  }


 nameUpdate(String a){ingredient.name=a;} //Namen der Tabelle Updatet

 getEditEntry(String table, String name) async{ //holt den Entry aus DB und übergibt ihn der Zutaten Klasse
    await db.getEntry(table , name);
    for(int i=0;i<db.result.length;i++){
          dbEntries.add(db.result[i]);   
        }
    ingredient.name=dbEntries[0]['Name'];  
    ingredient.bytes=dbEntries[0]['bytes'];
    pictureEdit=Image.memory(ingredient.bytes);
    ingredient.calories=dbEntries[0]['Calories'];
    ingredient.fat=dbEntries[0]['Fat'];
    ingredient.carbohydrates=dbEntries[0]['Carbohydrates'];
    ingredient.protein=dbEntries[0]['Protein'];
    ingredient.pieceGood=dbEntries[0]['pieceGood']== 0? false : true;
    isChecked=(dbEntries[0]['pieceGood'])== 0? false : true;
    ingredient.weight=dbEntries[0]['weight'];
    
      return "ready";
  }

nutritiontable(){   //Auflisten der Inhaltsstoffe und updaten dieser
  return Table(   
    columnWidths:   <int, TableColumnWidth>{ 
        2: FixedColumnWidth(MyProps.percent(context, 10)),
        1: FixedColumnWidth(MyProps.percent(context, 30)),
        0: const FlexColumnWidth()
          },
    children:<TableRow>[
      TableRow(
        children: <Widget>[
          Text("Name",style: TextStyle(fontSize: MyProps.fontSize(context, ""))),
          TextFormField(initialValue: ingredient.name,onChanged: ((value) =>  {nameUpdate(value)})) , 
          const Text(""),
          ]
      ),
     TableRow(
       children: <Widget>[
        Text("Kalorien",style:   TextStyle(fontSize: MyProps.fontSize(context, "")) ),
        TextFormField(
          initialValue: ingredient.calories.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.calories=double.parse(value)}},
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]) , 
        const Text("kcal"),
        ]
      ),
      TableRow(
        children: <Widget>[
          Text("Kohlenhydrate",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
          TextFormField(
           initialValue: ingredient.carbohydrates.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.carbohydrates=double.parse(value)}} ,
           keyboardType: TextInputType.number,
           inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
          const Text("g"),
            ]
       ),
        TableRow(
          children: <Widget>[Text("Fett",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
          TextFormField(
           initialValue: ingredient.fat.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.fat=double.parse(value)}} ,
           keyboardType: TextInputType.number,
           inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),  
          const Text("g"),
           ]
        ),
         TableRow(
           children: <Widget>[Text("Eiweiß",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
           TextFormField(
            initialValue: ingredient.protein.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.protein=double.parse(value)}} ,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
          const Text("g"),
          ]
         ),
        TableRow(
          children: <Widget>[Text("Gewicht:",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
          TextFormField(
            initialValue: ingredient.weight.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.weight=double.parse(value)}} ,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
          const Text("g"),
          ]
       ),
    ]
   );                
 }

  Future<String> warten() async{ //warten auf getEditEntry
    return await getEditEntry("Ingredients",widget.edible);
  }


    editSend() async{ // updatet die DB mit den neuen Werten
    await db.deleteentry( "Ingredients",dbEntries[0]['Name']);
    ingredient.save();
    navi(context, 23, "");
  }



@override
void initState() {
  super.initState();
  myFuture = warten();
}
  @override
  
Widget build(BuildContext context) {
 
  
   AppBar  appBar= AppBar(
      title: const Text("Editiere Zutat"),
    ); 
  return FutureBuilder(
   future: myFuture, 
   builder: (context,snapshot) {
    if (!snapshot.hasData){
      return const CircularProgressIndicator();}
   else{              
      if(fail!="OK") appBar= failbar(context, fail);
      return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    "Bild:",
                    style: TextStyle(fontSize: MyProps.fontSize(context, "huge")),
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ImgBox(  //Zeigt Bild an
                    label: ingredient.name,
                    onTap: () => {getImg(false)},
                    size: MyProps.itemSize(context, "huge"),
                    image: Image.memory(ingredient.bytes),
                    fontSize: MyProps.fontSize(context, "big"),
                  ),
            
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton( //Bild Hochladen Button
                      onPressed: () => {getImg(false)},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      child: const Text("Bild hochladen")),
                  SizedBox(width: MyProps.itemSize(context, "medium")),
                  Ink(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () => {getImg(true)},
                    ),
                  ),
                ],
              ),
              Padding(
               padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
               child:Column(
                children: [nutritiontable(), //Tabelle der Inhaltsstoffe
                  
                const Text("Stückware?") ,Checkbox( //Checkbox für Stückware
                  checkColor: Colors.white,
                  value: ingredient.pieceGood,
                  onChanged: (bool value) {
                    setState(() {
                      ingredient.pieceGood = value;                   
                      });
                  }
                )
              ]
            )
          )
         ]     
        )
       ),
     ),
     floatingActionButton: FloatingActionButton.extended( // edit button der den den Edit ausführt
      onPressed: ()  {
       editSend();
     },
     label: const Text("Edit"),
    ),
   );
  }}
 );
}}



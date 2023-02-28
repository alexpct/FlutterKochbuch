//Alex was here
import 'dart:convert';
import 'dart:developer';

import 'package:alert/alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/navi.dart';

import 'dart:io';

import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/widgets/iconbox.dart';
import 'package:flutter/services.dart';

import '../helper/imagepicker.dart';
import '../helper/objects.dart';

class editIn extends StatefulWidget {
   editIn( this.typ, this.edible);
  final String typ;
  final String edible;
  @override
  _editInState createState() => _editInState();
}

class _editInState extends State<editIn> {
  late final Future myFuture;
  var _image;
  final db = dbHelper();
  String name = "Name";
  String fail = "OK";
  Image? pictureedit;
  bool isChecked=false;
  List<Map<String, dynamic>>DbEntries=[];
  Ingredient ingredient=Ingredient(name: "Name", Calories: 0, pieceGood: true,);

  Uint8List?  bytesSave;


   getImg(bool useCamera) {
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
          _image = value;
        }));
  }


  /*EditType() async{
  switch(widget.typ){
      case "editZ": 
          await edit("Ingredients",widget.edible);
      break;
  default: print("nichts gefunden");
}
return "ready";
 }*/

 nameUpdate(String a){ingredient.name=a; ;print(ingredient.name);}

  edit(String table, String name) async{
  
    await db.getEntry(table , name);
    for(int i=0;i<db.result.length;i++){
  
          DbEntries.add(db.result[i]);
          print(DbEntries[i]['piecegood']);  
            
        }
      //pictureedit=Image.memory(DbEntries[0]['bytes']);
      isChecked=(DbEntries[0]['pieceGood'])== 0? false : true;

      ingredient.name=DbEntries[0]['Name'];
      ingredient.bytes=DbEntries[0]['bytes'];
      pictureedit=Image.memory(ingredient.bytes!);
      ingredient.Calories=DbEntries[0]['Calories'];
      ingredient.Fat=DbEntries[0]['Fat'];
      ingredient.Carbohydrates=DbEntries[0]['Carbohydrates'];
       ingredient.Protein=DbEntries[0]['Protein'];
      ingredient.pieceGood=DbEntries[0]['piecegood']== 0? false : true;
      ingredient.weight=DbEntries[0]['weight'];

      //bytesSave=DbEntries[0]['bytes'];
      //pictureedit=Image.memory(DbEntries[0]['bytes']);



      return "ready";
  }



  ingredientsTable(){  

    return Table(   
                       columnWidths:   <int, TableColumnWidth>{ // susi: hier dann auf 4 spalten gehen bzw 5 mit einer leeren Spalte dazwischen
                         2: FixedColumnWidth(myProps.percent(context, 10)),
                         1: FixedColumnWidth(myProps.percent(context, 30)),
                         0: FlexColumnWidth()
                       },
                       children:<TableRow>[
                         TableRow(
                             children: <Widget>[Text("Name",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.name,onChanged: ((value) =>  {nameUpdate(value)})
                             ) , Text(""),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kalorien",style:   TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Calories.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Calories=double.parse(value)}},keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]) , Text("kcal"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kohlenhydrate",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Carbohydrates.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Carbohydrates=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Fett",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Fat.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Fat=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),  Text("g"),
                             ]
                         ),

                         TableRow(
                             children: <Widget>[Text("Eiweiß",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.Protein.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.Protein=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Gewicht:",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: ingredient.weight.toString(),onFieldSubmitted: (value) => {if(value!=null&& value.isNotEmpty){ingredient.weight=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                           

                       ]
                   );
                    
                   }
  
  Future<String?> warten() async{
    return await edit("Ingredients",widget.edible);;
  }


    EditSend() async{
    await db.deleteentry( "Ingredients",DbEntries[0]['Name']);
    print(ingredient.pieceGood);
    ingredient.save();
    //await db.insertDBZ(ingredient.name, ingredient.bytes, DbEntries[0]['Calories'], DbEntries[0]['Fat'], DbEntries[0]['Protein'], DbEntries[0]['Carbohydrates'], isChecked, DbEntries[0]['weight'], "Ingredients");
    navi(context, 23, "");
  }



@override
void initState() {
  super.initState();

  // Assign that variable your Future.
  myFuture = warten();
}
  @override
  
  Widget build(BuildContext context) {
 
  
   AppBar  appBar= AppBar(
      title: Text("hinzufügen"),
    ); 
     return FutureBuilder(
  future: myFuture, // a Future<String> or null
  builder: (context,snapshot) {
        if (!snapshot.hasData){
          return CircularProgressIndicator();}
        else{      
           print(DbEntries[0]['Calories']);
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
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "Bild:",
                  style: TextStyle(fontSize: myProps.fontSize(context, "huge")),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ImgBox(
                  label: ingredient.name,
                  onTap: () => {getImg(false)},
                  size: myProps.itemSize(context, "huge"),
                  image: pictureedit,
                  fontSize: myProps.fontSize(context, "big"),
                ),
          
              ],),
            Row(
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
                    onPressed: () => {getImg(true)},
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child:Column(
                children: [ingredientsTable(),
                
              Text("Stückware?") ,Checkbox(
                 checkColor: Colors.white,
                 value: ingredient.pieceGood,
                 onChanged: (bool? value) {
                  
                   setState(() {
                    ingredient.pieceGood = value!;
                    print("check");
                    print(value);
                    
                     }
                   );
                   }
                   )
                   ]
                   )
                   )]     
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  {
          EditSend();
          },
        label: Text("Edit"),
      ),
    );
    }
    }
    );
    

    }
  }



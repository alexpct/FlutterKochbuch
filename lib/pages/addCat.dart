//Alex was here
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

class addCat extends StatefulWidget {
   addCat( this.typ, this.edible);
  final String typ;
  final String edible;
 // String title = "Kategorie hinzufügen";
  @override
  _addCatState createState() => _addCatState();
}

class _addCatState extends State<addCat> {
  var _image;
  final db = dbHelper();
  String name = "Name";
  String fail = "OK";
  Image pictureedit;
  List<Map<String, dynamic>>DbEntries=[];


  getImg(bool useCamera) {
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
          _image = value;
        }));
  }


  EditType() async{
  switch(widget.typ){
    case "editC": 
           await edit("Category", widget.edible);
      break;
      case "editZ": 
          await edit("ingredients",widget.edible);
      break;
      case "addC": 
          //await cate(typ);
      break;
  default: print("nichts gefunden");
}
return "ready";
 }

  add() async { /*
    print(_image);
    if (name == "Name") {setState(() {
      fail = "Bitte Namen eingeben";
    });return false;}
    if (_image != null) db.newRecipe(name, _image).then((value) =>setState(() { fail = value;}));
    else {setState(() {
      fail= "Bild hinzufügen";
    });}
    print(fail);
   if(fail=="OK") Alert(message: 'Kategorie hinzugefügt').show(); */

    if (name == "Name") {setState(() {
      fail = "Bitte Namen eingeben";
    });return false;}
    if(_image==null){setState(() {
      fail= "Bild hinzufügen";
    }); return false;}
    var  cat;
    await catFromFile(name, _image).then((value) => cat=value);
    cat.save().then((value) => fail=value);

   navi(context, 1,"");

  }

  edit(String table, String name) async{
  
    await db.getEntry(table , name);
    for(int i=0;i<db.result.length;i++){
  
          DbEntries.add(db.result[i]);
          print(DbEntries[i]['Name']);  
          log(DbEntries[i].toString());
          print(DbEntries[i]['Fat']); 
          print(DbEntries[i]['Carbohydrates']);
          print(DbEntries[i]['Protein']);                 
        }
      pictureedit=Image.memory(DbEntries[0]['bytes']);
      print("fertig");
      return "ready";
  }



  ingredientsTable(){
 
    if(widget.typ=="editZ"){
    return Table(

      
                       columnWidths:   <int, TableColumnWidth>{ // susi: hier dann auf 4 spalten gehen bzw 5 mit einer leeren Spalte dazwischen
                         2: FixedColumnWidth(myProps.percent(context, 10)),
                         1: FixedColumnWidth(myProps.percent(context, 30)),
                         0: FlexColumnWidth()
                       },
                       children:<TableRow>[
                         TableRow(
                             children: <Widget>[Text("Name",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['Name']
                             ) , Text(""),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kalorien",style:   TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['Calories'].toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){DbEntries[0]['Calories']=double.parse(value)}},keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]) , Text("kcal"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Kohlenhydrate",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['Carbohydrates'].toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){DbEntries[0]['Carbohydrates']=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Fett",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['Fat'].toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){DbEntries[0]['Fat']=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),  Text("g"),
                             ]
                         ),

                         TableRow(
                             children: <Widget>[Text("Eiweiß",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['Protein'].toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){DbEntries[0]['Protein']=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[Text("Gewicht:",style: TextStyle(fontSize: myProps.fontSize(context, "")) ),TextFormField(initialValue: DbEntries[0]['weight'].toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){DbEntries[0]['weight']=double.parse(value)}} ,keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), Text("g"),
                             ]
                         ),


                       ]
                   );}
                   else{

                      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Name:",
                    style:
                        TextStyle(fontSize: myProps.fontSize(context, "big")),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                    child: TextField(
                  style: TextStyle(
                    fontSize: myProps.fontSize(context, "big"),
                  ),
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                )),
                SizedBox(width: 100),
              ]);

                   }


  }
  Future<String> warten() async{
    return await EditType();
  }







  @override
  Widget build(BuildContext context) {
    // var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
     /*if(DbEntries.isEmpty){
      warten();
      print("init");
      }
        else print("voll");*/
    if(widget.typ=="editZ"|| widget.typ =="editC"){
   AppBar  appBar= AppBar(
      title: Text("hinzufügen"),
    ); 
     return FutureBuilder<String>(
  future: warten(), // a Future<String> or null
  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData){
          return CircularProgressIndicator();}
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
                  label: DbEntries[0]['Name'],
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
              child: ingredientsTable()/*Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Name:",
                    style:
                        TextStyle(fontSize: myProps.fontSize(context, "big")),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                    child: TextField(
                  style: TextStyle(
                    fontSize: myProps.fontSize(context, "big"),
                  ),
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                )),
                SizedBox(width: 100),
              ])*/,

            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //add();
          if(widget.typ=="editZ"){
          db.deleteentry(DbEntries[0]['Name'], "Ingredients");}
          else{
            db.deleteentry(DbEntries[0]['Name'], "Category");
          }
        },
        label: Text("Edit"),
      ),
    );}}
    );
    

    }
    else{

    AppBar  appBar= AppBar(
      title: Text("hinzufügen"),
      actions: [ElevatedButton(onPressed: add, child: const Text("+"))],
    );
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
                  label: name,
                  onTap: () => {getImg(false)},
                  size: myProps.itemSize(context, "huge"),
                  file: _image,
                  fontSize: myProps.fontSize(context, "big"),
                ),
              ],
            ),
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
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Name:",
                    style:
                        TextStyle(fontSize: myProps.fontSize(context, "big")),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                    child: TextField(
                  style: TextStyle(
                    fontSize: myProps.fontSize(context, "big"),
                  ),
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                )),
                SizedBox(width: 100),
              ]),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          add();
        },
        label: Text("Kategorie hinzufügen"),
      ),
    );
    }
  }
}

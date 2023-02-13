//Alex was here
import 'package:flutter/material.dart';


import 'dart:io';

import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/widgets/iconbox.dart';

import '../helper/imagepicker.dart';

class addCat extends StatefulWidget {
              String title="Kategorie hinzufügen";
  @override
  _addCatState createState() => _addCatState();
}

class _addCatState extends State<addCat> {
  var _image;
  var txt ="wurst0" ;
  final db = dbHelper();
  String name = "Name";


  getImg(bool useCamera){
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) =>setState(() { _image = value; }));

  }
 
  test() async {

    db.newRecipe("hoho", _image);
    await db.getCat()    ;
    try {
          txt=db.result[0]["Name"];
    }catch(e){txt="ohoh";};
    setState(() {});

    print(db.result);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [ElevatedButton(onPressed: test, child: const Text("+"))],
      ),
      body:SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),child: Text("Bild:", style: TextStyle(fontSize: myProps.fontSize(context, "huge")),),)
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImgBox(label: name, didTap:()=> {getImg(false)},size:myProps.itemSize(context, "huge"),image: _image,fontSize: myProps.fontSize(context, "big"),),
               ],
            ),
    Row(              mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ElevatedButton(onPressed:()=> {getImg(false)}, child: Text("Bild hochladen"),style: ButtonStyle(
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0)
                     )
                 )
             )
             ),
             SizedBox(width: myProps.itemSize(context, "medium")),
        Ink(
          decoration:  ShapeDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: CircleBorder(),
          ),
          child:  IconButton(
               icon: const Icon(Icons.add_a_photo),
               onPressed:()=> {getImg(true)},
             ),),
             
           ],
    ) ,             Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),child:   Row(mainAxisAlignment: MainAxisAlignment.start,
                children:[   SizedBox(width: 20),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: Text("Name:", style: TextStyle(fontSize: myProps.fontSize(context, "big")),),)    ,    SizedBox(width:10),
                  Flexible(
                    child: TextField(          style: TextStyle(
                      fontSize:  myProps.fontSize(context, "big"),
                    ),
                    onChanged:(text) {setState(() {
                      name=text;
                    });},)
                  ),   SizedBox(width: 100),
                ]),)

          ],
        )
      ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         test();
        },


              label:Text("Rezept hinzufügen"),
      ),
    );

  }
}


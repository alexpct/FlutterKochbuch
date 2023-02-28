
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
    addCat(  [this.edible]);
   final String? edible;
   String title = "Kategorie hinzufügen";
   @override
   _addCatState createState() => _addCatState();
 }
 
 class _addCatState extends State<addCat> {
   var _image;
   final db = dbHelper();
   String name = "Name";
   String fail = "OK";
   Image? pictureedit;
   List<Map<String, dynamic>>DbEntries=[];
 


  getImg(bool useCamera) {
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
          _image = value;
        }));
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





   @override
   Widget build(BuildContext context) {


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
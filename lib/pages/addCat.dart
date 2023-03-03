///

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


class AdEdCat extends StatefulWidget {
    AdEdCat( [this.edible]);
   final String edible;
   String title = "Kategorie hinzufügen";
   @override
   _AdEdCatState createState() => _AdEdCatState();
 }
 
 class _AdEdCatState extends State<AdEdCat> {
   var _image;
   final db = DbHelper();
   Future myFuture;  
   String name = "Name";
   String fail = "OK";
   bool checkMode = false;
   Image pictureedit;
   String dbName="";
   String titel;
   String buttonTitel="hinzufügen";
   Uint8List dbPic;
   List<Map<String, dynamic>>dbEntries=[];

   Future<String> check() async{
    if(widget.edible==null){
       titel="Kategorie hinzufügen";
       return "ready";
      }
    else{
      checkMode=true;
      titel ="Kategorie bearbeiten";
      buttonTitel="bearbeiten";
      await db.getEntry("Category", widget.edible);
      for(int i=0;i<db.result.length;i++){
          dbEntries.add(db.result[i]);  

        }
       dbName=dbEntries[0]['Name'];
       dbPic=dbEntries[0]['Pic'];
       pictureedit=Image.memory(dbPic);
       return"ready";
      }
   }

  getImg(bool useCamera) {
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
          _image = value;
        }));
  }

  add() async { 
   
    if (dbName == "Name") {setState(() {
      fail = "Bitte Namen eingeben";
    });return false;}
    if(_image==null){setState(() {
      fail= "Bild hinzufügen";
    }); return false;}
    var cat;
    await catFromFile(dbName, _image).then((value) => cat=value);
    cat.save().then((value) => fail=value);

    navi(context, 1);

  }

  editSend() async{ 
    await db.deleteentry("Category",dbEntries[0]['Name']);
    var  cat= await Future<Cat>.value(Cat(name: dbName, bytes: dbPic));
    cat.save().then((value) => fail=value);
    navi(context, 1);
  }


  @override
  void initState() {
    super.initState();
    myFuture = check();
}

   @override
Widget build(BuildContext context) {

 return FutureBuilder(
   future: myFuture, 
   builder: (context,snapshot) {
    if (!snapshot.hasData){
      return const CircularProgressIndicator();}
   else{ 
    AppBar  appBar= AppBar(
      title: Text(titel),
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
                ImgBox(
                  label: dbName,
                  onTap: () => {getImg(false)},
                  size: MyProps.itemSize(context, "huge"),
                  image: pictureedit,
                  file: _image,
                  fontSize: MyProps.fontSize(context, "big"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
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
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(width: 50),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  
                ),

                Flexible(
                    child: TextFormField(
                      initialValue: dbName,                         
                  style: TextStyle(
                    fontSize: MyProps.fontSize(context, "big"),
                  ),
                  decoration: const InputDecoration(               
                    labelText: 'Name',
                   ),
                  onChanged: (text) {
                    setState(() {
                      dbName = text;
                    });
                  },
                )),
                const SizedBox(width: 50),
              ]),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(widget.edible==null){
          add();
          }else{
             editSend();
          }
        },
        label: Text(buttonTitel),
      ),
    );
   }});
   
   }}

//Alex was here
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/dbhelper.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';
import '../helper/objects.dart';
import '../pages/testpage.dart';

class recipe extends StatefulWidget {
  recipe({ this.category=""});

// Es fehlt so viel, so viel das wichtig ist, es werden fast keine Fehler
// abgefangen, es ist fast nichts typsicher, die datenbank kaskadiert nicht
// anständig und und und, aber das kommt davon wenn man zuviel in zu wenig Zeit
// will(nicht das sie zu wenig Zeit gegeben haben, aber wann man anfängt )
  final String title = "Rezepte";
  final String category;





  @override
  State<recipe> createState() => _recipeState(dbHelper);
}

class _recipeState extends State<recipe> {
  _recipeState(this.db){

    test2();
  }
  var db ;
  List<Cat> imagefill=[];
  List<File> imagesreally=[];



 test2() async {
  db = await dbHelper();
   await db.getCat();
   print( db.result);
   for(int i=0;i<db.result.length;i++){
  
    imagefill.add( Cat(name: db.result[i]['Name'], bytes: db.result[i]['Pic']));
   }
   setState(() {

   //imagesreally=imagefill[0].image as List<File?>;

   });
 }
 
  

  @override
  Widget build(BuildContext context) {
   //if(!true)print(images[0]);
  

    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      bottomNavigationBar:  BotNav(Index:1),
      body: Center(
        // 
        child:Padding(
          padding: EdgeInsets.all(myProps.percent(context, 2)),
          
          child: GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: myProps.percent(context, 2),
            mainAxisSpacing: myProps.percent(context, 2),
                  
            ),
            itemCount: imagefill.length,
            itemBuilder: (BuildContext context, int index) {
              
              
              final item = imagefill[index];
              return ImgBox(label: item.name, onTap: () =>null, image: item.image,size: myProps.itemSize(context, "normal"),noMargin: true,);
              
             }),
        )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

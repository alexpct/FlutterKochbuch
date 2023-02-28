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
  List<Cat> imageOrig=[];
  List<File> imagesreally=[];


resize(){
  if(MediaQuery.of(context).viewInsets.bottom==1){
 return EdgeInsets.only(top: myProps.percent(context, 20));
  }
  else{
    return EdgeInsets.all(myProps.percent(context, 2));

  };

}



 test2() async {
  db = await dbHelper();
   await db.getCat();
   print( db.result);
   for(int i=0;i<db.result.length;i++){
  
    imagefill.add( Cat(name: db.result[i]['Name'], bytes: db.result[i]['Pic']));
    imageOrig.add( Cat(name: db.result[i]['Name'], bytes: db.result[i]['Pic']));
   }
   setState(() {

   //imagesreally=imagefill[0].image as List<File?>;

   });
 }
 
  onChange(String text){
    List<Cat> filtered=[];
    for(var i=0; i<imageOrig.length;++i){
      if (imageOrig[i].name.toLowerCase().startsWith(text.toLowerCase())) filtered.add(imageOrig[i]);
    }
    setState(() {
      imagefill=filtered;
    });

  }

  @override
  Widget build(BuildContext context) {
   //if(!true)print(images[0]);
  

    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
       
        title: Text(widget.title),
      ),

      bottomNavigationBar: BotNav(Index:1),
      body:  SingleChildScrollView(      
        //reverse: true,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

               
    Container(
      
      height: myProps.percent(context, 150),
      
       //padding: EdgeInsets.only(top: myProps.percent(context, 20)),
        padding: EdgeInsets.all(myProps.percent(context, 2)),


        child: GridView.builder(
          
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
      ),
      Center(
      child:Container(
        height: myProps.percent(context, 12), 
        width: myProps.percent(context, 95),
                
        child:TextField(
        onChanged: (text) {
            onChange(text);},
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Search',
        
  )),
),)
      
      ])
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}

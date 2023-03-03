//Susi was here  ///

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/pages/RecipeList.dart';

import '../helper/dbhelper.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';
import '../helper/objects.dart';

class ShowCat extends StatefulWidget {
  const ShowCat({Key key,  this.category=""}) : super(key: key);

  final String title = "Kategorien";
  final String category;


  @override
  State<ShowCat> createState() => _ShowCatState(DbHelper);
}

class _ShowCatState extends State<ShowCat> {
  _ShowCatState(this.db){

    getDb();
  }
  var db ;
  List<Cat> imagefill=[]; // Liste für die geholten Einträge aus der DB
  List<Cat> imageorig=[]; // Liste für die Filter funktion


 getDb() async { //Holt die Einträge aus der DB und steck sie in 2 Listen
   db = DbHelper();
   await db.getCat();
   for(int i=0;i<db.result.length;i++){
  
      imagefill.add( Cat(name: db.result[i]['Name'], bytes: db.result[i]['Pic']));
      imageorig.add( Cat(name: db.result[i]['Name'], bytes: db.result[i]['Pic']));
   }
   setState(() {

   });
 }

 gotoShowList(int index){

   Navigator.push(
   context,
   PageRouteBuilder(
   pageBuilder: (_, __, ___) =>  RecipeList(category: imagefill[index].name,),
   transitionDuration: const Duration(seconds: 0),
   )) ;
 }
  filter(String text){ // Filter funktion für das Textfeld
    List<Cat> filtered=[]; //Liste mit gewünschter Filterung
    for(var i=0; i<imageorig.length;++i){
        if (imageorig[i].name.toLowerCase().contains(text.toLowerCase())) filtered.add(imageorig[i]); // übergibt filterung an neue Liste filtered
    }
    setState(() {
      imagefill=filtered; //updatet die angezeigte Liste
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(      
        title: Text(widget.title),
      ),

      bottomNavigationBar: const BotNav(Index:1),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Center(
              child:Container(
                padding: EdgeInsets.fromLTRB(0, MyProps.percent(context, 3), 0, 0),
                height: MyProps.percent(context, 12),
                width: MyProps.percent(context, 95),
                child:TextFormField( //Textfield der Suche
                    onChanged: (text) {
                      filter(text);},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Suche',
                    )),
              ),),

            Container(
              padding: EdgeInsets.all(MyProps.percent(context, 2)),
                child: Container(
                  child: GridView.builder( //Builder für das Kategorien Layout
                  physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: MyProps.percent(context, 2),
                      mainAxisSpacing: MyProps.percent(context, 2),

                    ),
                    itemCount: imagefill.length,
                    itemBuilder: (BuildContext context, int index) {

                      final item = imagefill[index];
                      return ImgBox(label: item.name, onTap: () =>gotoShowList(index), image: item.image,size: MyProps.itemSize(context, "normal"),noMargin: true,); //Bilder der Kategorien
                    }
                  ),
               ),
            ),
         ] 
        )
     )
    );
  }
}

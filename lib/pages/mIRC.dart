//Susann   ///

import 'package:flutter/material.dart';
import 'package:kochbuch/pages/addCat.dart';
import 'package:kochbuch/pages/editIn.dart';
import 'package:kochbuch/pages/newRecipe.dart';
import '../helper/objects.dart';
import '../widgets/botnav.dart';
import '../helper/dbhelper.dart';


class ManageIRC  extends StatefulWidget {
    const ManageIRC({Key key, this.type}) : super(key: key);

   final String type;
  
  @override
  State<ManageIRC> createState() => _ManageIRCState();
}

class _ManageIRCState extends State<ManageIRC> {

  _ManageIRCState();

List<Map<String, dynamic>>entrylist=[]; //Liste mit geholten DB einträgen
var  db ; //helper
String titel=""; //Appbar Titel
int editnav;

getNamefromDb(String typ) async { //holen aller Namen aus typ (Kategorie/Zuatetn/Rezept) DB
  db = DbHelper();
  await db.getName(typ);
  for(int i=0;i<db.result.length;i++){
     entrylist.add(db.result[i]);      
   }
  setState(() {
   });       
}

 listing( String typ) async{  //Welche Liste geladen werden soll
  switch(typ){
    case "Category": 
          await getNamefromDb(typ);
          titel="Kategorien";
          editnav=0;
      break;
      case "Ingredients": 
          await getNamefromDb(typ);
          titel="Zutaten";
          editnav=3;
      break;
      case "Recipe": 
          await getNamefromDb(typ);
          titel="Rezepte";
          editnav=0;
      break;
   default: print("nichts gefunden");
  }
}

nav( String typ) async{ 
  switch(widget.type){
    case "Category": 
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => AdEdCat(typ),
          transitionDuration: const Duration(seconds: 0),
        )) ;
      break;
      case "Ingredients": 
          Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditIn(typ),
          transitionDuration: const Duration(seconds: 0),
        )) ;
          
      break;
      case "Recipe": 
      db = DbHelper();
      Recipe rez =await db.getRecipe(typ);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewRecipe(recipe: rez),
          transitionDuration: const Duration(seconds: 0),
        )) ;
          
      break;
   default: print("nichts gefunden");
  }
}




warten() async{   //warten auf listing 
  await listing(widget.type);
}

deleteListItem(int index, String name, String typ)  async { //funktion des löschen Buttons
    await db.deleteentry(typ,name);
    entrylist=[];
    await warten();
}

deletealert(int index, String name, String typ){    // Alertdialog des Löschen Buttons
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
    title: const Text('Wollen sie wirklich löschen?'),
     actions: <Widget>[
       TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Abbrechen'),
        ),
       TextButton(
        onPressed:() {
          deleteListItem(index, name,typ);
          Navigator.pop(context, 'Cancel');      
          },
        child: const Text('OK'),
      )
     ],
    ),
   );  
  }


  @override
  Widget build(BuildContext context) {
    if(entrylist.isEmpty){
      warten();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(titel),
      ),
      bottomNavigationBar:  const BotNav(index:2),
      body: Center(
        child:
        ListView.builder( //auflistung der entrylist
            padding: const EdgeInsets.all(8),
            itemCount: entrylist.length,
            itemBuilder: (BuildContext context, int index) {
              final String item = entrylist[index]['Name'];
              return ListTile(title: Text(item), 
                trailing: Wrap(
                  spacing: 1,
                  children: <Widget>[
                    IconButton(onPressed: () => nav(item), icon: const Icon(Icons.edit)), //edit button leitet weiter zu edit page 
                    IconButton(onPressed: ()=> deletealert(index,item,widget.type), icon: const Icon(Icons.delete)) //löschen button

                  ]
                )
              );
            }
        ),
      )
    );
  }
}
//Alex was here - aaaaand now its not the best IRC client on earth, its "manage ingredients recipes categories"  :P wow echt lustig /o\ - susi

import 'package:flutter/material.dart';
import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../helper/dbhelper.dart';
import '../helper/objects.dart';

class mIRC  extends StatefulWidget {
    const mIRC({super.key,  required this.type});

   final String type;
  
  @override
  State<mIRC> createState() => _mIRCState();
}

class _mIRCState extends State<mIRC> {

  _mIRCState() {
   //listing("category");
  }

List<Map<String, dynamic>>listforthings=[];
List<String?> StupidList=[];
var  db ;

cate(String typ) async {
         db = await dbHelper();
        await db.getsomething(typ);
        //print( db.result);
        for(int i=0;i<db.result.length;i++){
  
          listforthings.add(db.result[i]);
          print(listforthings[i]['Name']);             
        }
         print("bin hier richtig");

         setState(() {

   });
         
      }

 listing( String typ) async{
  switch(typ){
    case "category": 
          await cate(typ);
      break;
  default: print("nichts gefunden");
}
 }

warten() async{
  await listing(widget.type);
}

deleteListItem(int index, String name, String typ)  async {
   //listforthings.removeAt(index);
    await db.deleteentry(typ,name);
    listforthings=[];
    await warten();
   

}



  @override
  Widget build(BuildContext context) {

  if(listforthings.isEmpty){
    warten();
  }
  else print("voll");

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.type),
      ),
      bottomNavigationBar:  const BotNav(Index:2),
     
      body: Center(
      child: 
      ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: listforthings.length,
      itemBuilder: (BuildContext context, int index) {
        final item = listforthings[index]['Name'];

        return ListTile(title: Text(item), trailing: IconButton(onPressed: ()=> deleteListItem(index,item,widget.type), icon: Icon(Icons.delete)));

    }
          

      )
      ,
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
//IconBox(label: "Rezepte Verwalten", icon: Icons.ramen_dining,didTap: () =>null)
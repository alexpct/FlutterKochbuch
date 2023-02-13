//Alex was here - aaaaand now its not the best IRC client on earth, its "manage ingredients recipes categories"  :P

import 'package:flutter/material.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';

class mIRC  extends StatefulWidget {
  const mIRC({super.key, required this.type});


  final String type;

  @override
  State<mIRC> createState() => _mIRCState();
}

class _mIRCState extends State<mIRC> {

 void  newItem(){
  switch(widget.type){
    case "categories": navi(context, 22); break;

  }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.type),
      ),
      bottomNavigationBar:  const BotNav(Index:2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         newItem();
        },
        child: const Icon(Icons.add),
      ),
      body:
      Column(
          children:  <Widget>[
            const Text("List comes here"),

          ]


      )
      ,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//IconBox(label: "Rezepte Verwalten", icon: Icons.ramen_dining,didTap: () =>null)
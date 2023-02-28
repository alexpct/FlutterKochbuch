//Alex was here
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class Manage extends StatefulWidget {


  final String title="Verwaltung";

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar:  BotNav(Index:2),
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, 

    children: <Widget>[

      ImgBox(label: "Kategorie\n", icon: Icons.menu_book, onTap: () => navi(context,4,""),size: myProps.itemSize(context, "normal"), ),
      ImgBox(label: "Zutaten\n ", icon: Icons.kebab_dining,onTap: () =>navi(context,23,""),size: myProps.itemSize(context, "normal"),),
      ImgBox(label: "Rezepte\n", icon: Icons.ramen_dining,onTap: () =>navi(context,23,""),size: myProps.itemSize(context, "normal"),),
       ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}

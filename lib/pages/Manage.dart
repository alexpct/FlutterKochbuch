//Alex was here   ///
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class Manage extends StatefulWidget {


  final String title="Verwaltung";

  const Manage({Key key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar:  const BotNav(Index:2),
        body: Center(
          child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, 

            children: <Widget>[

              ImgBox(label: "Kategorien\n", icon: Icons.menu_book, onTap: () => navi(context,21,""),size: MyProps.itemSize(context, "normal"),),
              ImgBox(label: "Zutaten\n ", icon: Icons.kebab_dining,onTap: () =>navi(context,23,""),size: MyProps.itemSize(context, "normal"),),
              ImgBox(label: "Rezepte\n", icon: Icons.ramen_dining,onTap: () =>navi(context,24,""),size: MyProps.itemSize(context, "normal"),),

           ]
          ),
        )
    );
  }
}

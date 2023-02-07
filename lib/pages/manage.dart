//Alex was here
import 'package:flutter/material.dart';

import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class Manage extends StatefulWidget {
  const Manage({super.key});


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
      body: Wrap(
    alignment: WrapAlignment.spaceBetween,
    direction: Axis.horizontal,

    children: <Widget>[

      IconBox(label: "Kategorie verwalten", icon: Icons.menu_book, didTap: () => navi(context,21) ),
      IconBox(label: "Zutaten Verwalten", icon: Icons.kebab_dining,didTap: () =>null),
      IconBox(label: "Rezepte Verwalten", icon: Icons.ramen_dining,didTap: () =>null),
       ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

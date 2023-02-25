//Alex was here
import 'package:flutter/material.dart';

import '../helper/dbhelper.dart';
import '../widgets/botnav.dart';

class recipe extends StatefulWidget {
  recipe({super.key, this.category=""});

// Es fehlt so viel, so viel das wichtig ist, es werden fast keine Fehler
// abgefangen, es ist fast nichts typsicher, die datenbank kaskadiert nicht
// anständig und und und, aber das kommt davon wenn man zuviel in zu wenig Zeit
// will(nicht das sie zu wenig Zeit gegeben haben, aber wann man anfängt )
  final String title = "Rezepte";
  final String category;


  @override
  State<recipe> createState() => _recipeState();
}

class _recipeState extends State<recipe> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar:  BotNav(Index:1),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Recipie gets here',
            ),
            ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

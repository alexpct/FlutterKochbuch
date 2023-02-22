//Alex was here
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/dbhelper.dart';
import '../widgets/botnav.dart';

class IngredientPage extends StatefulWidget {
  IngredientPage({super.key,});


  final String title = "Zutat hinzufügen";
  final db = dbHelper();

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {

  @override
  Widget build(BuildContext context) {
    var wid = Container( height: 100 ,width: myProps.minScreen(context),color: Colors.red);

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
          Padding(
            padding:  EdgeInsets.all(myProps.percent(context, 2)),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Zutat suchen'),
              ),
            ),
          ),
          Row(
            children: [
 wid
            ],
          )],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Alex was here
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/NutriAPI.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';

import '../helper/dbhelper.dart';
import '../helper/imagepicker.dart';
import '../helper/navi.dart';
import '../helper/objects.dart';
import '../widgets/botnav.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class Testpage extends StatefulWidget {
  const Testpage({super.key});


  final String title="Verwaltung";

  @override
  State<Testpage> createState() => _TestState();
}

class _TestState extends State<Testpage> {
  final db = dbHelper();
  List<Cat> cats = [];
  String txt = "wow";

  test13() {
    NutriAPI n = NutriAPI();

    n.search("Apfel");
  }

  bool c = false;
  late Uint8List cc;

  test56() async {
    print("network image test start");
    final response = await http.get(
        Uri.parse(
            'https://m.media-amazon.com/images/I/718Rv7lY0HL._AC_SL1500_.jpg'));

    print(response.bodyBytes.runtimeType);
    cc = response.bodyBytes;
    setState(() {
      c = true;
    });
    print("network image test end");
  }
 testA(){

    String str="Apfelkuchen mit Sahne";
    var idx  = str.indexOf(" ",12);

 var res= str.substring(0,idx).trim()+"\n"+ str.substring(idx+1).trim();
 print(res);
 }
bool d = false;
  var dd;
  testB() async {
    print("Ingredient Test start");
    final response = await http.get(
        Uri.parse(
            'https://m.media-amazon.com/images/I/718Rv7lY0HL._AC_SL1500_.jpg'));
Ingredient wurst = Ingredient(name: "Wurst", Calories: 1337,pieceGood: true);
Ingredient kaese = Ingredient(name: "Apfelhuchen mit marmelade und was weiß ich nnicht", Calories: 1337,Fat: 12, Carbohydrates: 15, Protein: 55, bytes:response.bodyBytes, pieceGood: true );


dd= null;

setState(() {
  d=true;
});

  }

  test() async {




  }


  @override
  Widget build(BuildContext context) {
    Widget wid;
    if (!cats.isEmpty) print(cats.last.bytes);
    if (cats.isEmpty)
      wid = Text("wurst");
    else {
      wid = Image.memory(cats.last.bytes);
      print("wtf?");
    }


    if (b) {
      Cat cat = Cat(name: "wurst", bytes: v);
      wid = Image.memory(cat.bytes);
      // wid = Image.file(_image);

    }


    if (c) {
      print("if c");
      wid = Image.memory(cc);
      //wid=Image.network('https://m.media-amazon.com/images/I/718Rv7lY0HL._AC_SL1500_.jpg');
    }
    if(d) wid=dd;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        bottomNavigationBar: BotNav(Index: 2),
        body: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Wrap(

                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,

                    children: <Widget>[Row(
                      children: [
                      ],

                    ),
                      Text(txt), ElevatedButton(
                        style: null,
                        onPressed: () => {test()},
                        child: const Text('First'),
                      ), ElevatedButton(
                        style: null,
                        onPressed: () => {test2()},
                        child: const Text('Second'),
                      ), ElevatedButton(
                        style: null,
                        onPressed: () => {test1337()},
                        child: const Text('Third'),
                      ),
                      wid,
                    ]),
                ])
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  test14() async {
    print("Start");
    //String URI ="https://trackapi.nutritionix.com/v2/search/instant?query=Ei&locale=de_DE&branded=false&detailed=true";
    String URI = 'https://www.chefkoch.de/rezepte/2530321396520682/Risotto-mit-Champignons-und-Radicchio.html';

    final response = await http.get(
      Uri.parse(URI),
      headers: {
        'x-app-id': '7b773536',
        'x-app-key': '7ff5548603c326b1bca3af594e3f437b',
      },
    );
    print("ready");
    var decode = jsonDecode(response.body);
    print(decode);
    setState(() {
      txt = decode['common'][0]['photo']['thumb'];
    });
  }

  test2() async {
    await db.getCat();
    print(db.result);

    cats.add(Cat(name: db.result[1]['Name'], bytes: db.result[1]['Pic']));

    setState(() {

    });
  }

  var _image;
  var v;
  bool b = false;

  getImg(bool useCamera) {
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) =>
        setState(() {
          _image = value;
        }));
  }

  test1337() async {
    v = await _image.readAsBytes();
    print(v);
    setState(() {
      b = true;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'botnav.dart';

class ShortLoadingScreen extends StatelessWidget {

  ShortLoadingScreen({this.title, this.index});
int index;
String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar:  BotNav(Index:index),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child: CircularProgressIndicator(strokeWidth: 5),width: myProps.itemSize(context, "fill"), height:  myProps.itemSize(context, "huge") ) , Text("Wenn du das lesen kannnst warst du schnell oder es lief was schief"),
          ],
        ),
      ),
    );
}}
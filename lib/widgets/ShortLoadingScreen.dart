import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'botnav.dart';

class ShortLoadingScreen extends StatelessWidget {

  ShortLoadingScreen({Key key, this.title, this.index}) : super(key: key);
int index;
String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar:  BotNav(index:index),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MyProps.itemSize(context, "fill"), 
              height:  MyProps.itemSize(context, "huge"), 
              child: const CircularProgressIndicator(strokeWidth: 5) 
              ) , 
           const Text("Wenn du das lesen kannnst warst du schnell oder es lief was schief"),
          ],
        ),
      ),
    );
}}
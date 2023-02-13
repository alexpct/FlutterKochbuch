//Alex was here
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgBox extends StatelessWidget{
  ImgBox({super.key, required this.label, this.icon, required this.didTap,this.image,this.size=100,this.fontSize=25});
  final String label;
  final IconData? icon;
  final VoidCallback didTap;
  File? image;
  final double? size;
  double fontSize;




  @override
  Widget build(BuildContext context) {
       var wid;
       if(image!=null){
         wid = Image.file(image!,width: size, height: size);
       }
       else  wid = Icon(
         icon ?? Icons.favorite ,
         color:Theme.of(context).colorScheme.primary,
         size: size??60,
       );
    return(
        InkWell(
          onTap: () {
           didTap();
          }
          ,
          child:  Container(
            margin: const EdgeInsets.all(40),
            padding: const EdgeInsets.all(5),
            width: size!+size!/4 ,
            height: size!+size!/4 ,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary, width:   size!/30)
            ),

            child:FittedBox(

                child:Column(
              mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[  wid ,Text(label, textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize), )],
     )),
    )
    ));
  }



}
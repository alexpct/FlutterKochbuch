//Alex was here
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

class ImgBox extends StatelessWidget{
  ImgBox({super.key, required this.label, this.icon, required this.didTap,this.image,this.size=-1,this.fontSize=25});
  final String label;
  final IconData? icon;
  final VoidCallback didTap;
  File? image;
  double? size;
  double fontSize;




  @override
  Widget build(BuildContext context) {
    if(size!<0)size=myProps.itemSize(context, "small");
       var wid;
       if(image!=null){
         wid = Image.file(image!,width: size, height: size);
       }
       else  wid = Icon(
         icon ?? Icons.favorite ,
         color:Theme.of(context).colorScheme.primary,
         size: size,
       );
    return(
        InkWell(
          onTap: () {
           didTap();
          }
          ,
          child:  Container(
            margin:  EdgeInsets.all(myProps.itemSize(context, "tiny")),
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
//Alex was here
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

class ImgBox extends StatelessWidget{
  ImgBox({super.key, required this.label, this.icon,this.image, required this.onTap,this.file,this.size=-1,this.fontSize=25
  , this.noMargin=false, this.noBorder=false}){
if (label.length > _maxChar) _labelSplit();

}
  final int _maxChar =11;
  String label;
  final IconData? icon;
  final VoidCallback onTap;
  File? file;
  Image? image;
  double? size;
  double fontSize;
  bool noMargin;
  bool noBorder;


  _labelSplit(){
    int idx  = label.indexOf(" ",5);
    String hyphen ="";
    if (!isBetween(idx,0,_maxChar)){ idx = _maxChar; hyphen="-";}
    String sub1 = label.substring(0,idx).trim();
    String sub2 = label.substring(idx+1);
    if(sub2.length>_maxChar) sub2 =sub2.substring(0,11).trimRight();
    label = sub1+hyphen+"\n"+sub2;
    if(fontSize==25) fontSize=15;


  }

  @override
  Widget build(BuildContext context) {
    if(size!<0)size=myProps.itemSize(context, "small");
       var wid;
       if(file!=null){
         wid = Image.file(file!,width: size, height: size);
       }
       else if (image!=null) wid = Container(child: image, width: size, height: size);
       else  wid = Icon(
         icon ?? Icons.favorite ,
         color:Theme.of(context).colorScheme.primary,
         size: size,
       );
Border? b=  Border.all(color: Theme.of(context).colorScheme.primary, width:  size!/30);
if(noBorder) b=null;
    return(
        InkWell(
          onTap: () {
           onTap();
          }
          ,
          child:  Container(
            margin:  EdgeInsets.all(noMargin? 0:   myProps.itemSize(context, "tiny")),
            padding: const EdgeInsets.all(5),
            width: size!+size!/4 ,
            height: size!+size!/4 ,
            decoration: BoxDecoration(
                border: b
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
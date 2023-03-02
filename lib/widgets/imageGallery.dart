import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/imagepicker.dart';
import 'iconbox.dart';

class ImageGallery extends StatefulWidget {
ImageGallery({this.images,this.onChange,this.editable=false});
  List<Uint8List> images= <Uint8List>[];
  bool editable;
final Function(List<Uint8List>)  onChange;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {

  int index=0;
  left(){
    if(index==0) setState(() {
      index=widget.images.length-1;
    });else setState(() {
      index--;
    });;
  }
  right(){
    if (index<widget.images.length-1) setState(() {
      index++;
    });else setState(() {
      index=0;
    });
  }
  getImg(bool useCamera) async {
    widget.images??=  <Uint8List>[];

    Future<File> ip = imgPicker(useCamera);
File file;
    await ip.then((value) => setState(()=>{file=value}));


    Uint8List  bytes = await file.readAsBytes();

    setState(() {
      widget.images.add(bytes);
      index=widget.images.length-1;
    });
    widget.onChange(widget.images);
  }
  @override
  Widget build(BuildContext context) {
    double size=myProps.minScreen(context)*0.9;
    Color primaryColor= Theme.of(context).colorScheme.primary;

    Widget boxChild;
    boxChild= Icon(
      Icons.favorite ,
      color:primaryColor,
      size: size*0.6,
    );
    if(widget.images!=null && widget.images.isNotEmpty)boxChild=Image.memory(widget.images[index], width: size*0.6, height: size*0.6,);


    List<List<Widget>> dots=[];
    int doti=0;
    if (widget.images!=null) {
      if(index==0)doti=0;
      else if (index==widget.images.length-1)doti=2;
      else doti=1;
    }
    dots.add([Icon(Icons.circle, size: size*0.1,color: primaryColor,),Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor),Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor)]);
    dots.add([Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor),Icon(Icons.circle, size: size*0.1,color: primaryColor,),Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor)]);
    dots.add([Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor),Icon(Icons.circle_outlined, size: size*0.1,color: primaryColor),Icon(Icons.circle, size: size*0.1,color: primaryColor,)]);

    List<Widget> editrow;
    if(widget.editable) {
      editrow=[ ElevatedButton(
        onPressed: () => {getImg(false)},
        child: Text("Bild hochladen"),
        style: ButtonStyle(
            shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18.0))))),
      SizedBox(width: myProps.itemSize(context, "medium")),
      Ink(
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.add_a_photo),
          onPressed: () => {getImg(true)},
        ),
      ),
    ];
    } else editrow=[];

    return FittedBox(
fit: BoxFit.contain,
      child:
      Container(

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:   [
                Center(
                    child: InkWell( child: Icon(Icons.chevron_left, size: size*0.2,color: primaryColor,),onTap: left,)
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: AnimatedSwitcher(//meh keine lust und Zeit f
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child:FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: size*0.02)

                          ),
                          child: Padding(
                            padding: EdgeInsets.all(size*0.02),
                            child:  boxChild ,
                          ),
                        ),
                      )
                    ),


                  ),
                ),
                Center(
                    child: InkWell( child: Icon(Icons.chevron_right, size: size*0.2,color: primaryColor,),onTap: right,)
                ),



              ],
            ),

            //////////////////////////////////////////////////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                dots[doti]
              ,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:editrow,
            )


          ],
        ),
      )

    );


  }
}
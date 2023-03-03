//Alex was here  ///
import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:kochbuch/helper/NutriAPI.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';
import 'package:flutter/services.dart';

import '../helper/dbhelper.dart';
import '../helper/imagepicker.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';


class NewIngredient extends StatefulWidget {

  final String title = "Zutat hinzufügen";
  final db = DbHelper();
  Ingredient ingredient=Ingredient(name: "Name", calories: 0, pieceGood: true,);

  NewIngredient({Key key}) : super(key: key);

  @override
  State<NewIngredient> createState() => _NewIngredientState();
}

class _NewIngredientState extends State<NewIngredient> {
  NutriAPI nutriAPI= NutriAPI();
  List<Ingredient> iList=[];
  Ingredient ingredient;
  bool isChecked=false;

 onTap(value){
  ingredient=value;
 setState(() {
  enterEdit();
});
}

 getImg(bool useCamera) async {
    var _image;
    Future<File> ip = imgPicker(useCamera);
    ip.then((value) => setState(() {
      _image  = value;
    })).then((a) => ingredient.image=Image.file(_image))
        .then((value) async => ingredient.bytes= await _image.readAsBytes())
        .then((value) => enterEdit());
  }

 add(){
    ingredient.save();Navigator.pop(context);
  }

  nameUpdate(String a){
    ingredient.name=a; enterEdit();
  }

enterEdit(){
   ingredient ??= widget.ingredient;
   wid=Expanded(
     child:  SingleChildScrollView(
       child: Column(
         children: [
           Padding(
             padding:  EdgeInsets.all(MyProps.percent(context, 3)),
             child: SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [const Text("Stückware?") ,Checkbox(
                 checkColor: Colors.white,
                 value: isChecked,
                 onChanged: (bool value) {
                   setState(() {

                     isChecked = value;
                     ingredient.pieceGood= isChecked;
                     enterEdit();}
                   );})]),
                   Padding(
                     padding:  EdgeInsets.all(MyProps.percent(context, 5)),
                     child: Row(
                      children: [const Text("Nährwerte pro 100g/Stück"), ImgBox(
                        label: ingredient.name,
                        onTap: () => {getImg(false)},
                        size: MyProps.itemSize(context, "small"),
                        image: ingredient.image,
                        fontSize: MyProps.fontSize(context, "big"),
                      ),]
                     )
                   ),
                   Table(
                       columnWidths:   <int, TableColumnWidth>{ 
                         2: FixedColumnWidth(MyProps.percent(context, 10)),
                         1: FixedColumnWidth(MyProps.percent(context, 30)),
                         0: const FlexColumnWidth()
                       },
                       children:<TableRow>[
                         TableRow(
                             children: <Widget>[
                              Text("Name",style:TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                              TextFormField(
                                initialValue: ingredient.name,
                                onFieldSubmitted:(a)=>{nameUpdate(a)},
                                onTap: enterEdit,) , 
                                const Text(""),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[
                              Text("Kalorien",style:   TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                              TextFormField(
                                initialValue: ingredient.calories.toString(),
                                onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.calories=double.parse(value)}},
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]) , 
                              const Text("kcal"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[
                              Text("Kohlenhydrate",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                              TextFormField(
                                initialValue: ingredient.carbohydrates.toString(),
                                onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.carbohydrates=double.parse(value)}} ,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
                              const Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[
                             Text("Fett",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                             TextFormField(
                              initialValue: ingredient.fat.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.fat=double.parse(value)}} ,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),  
                             const Text("g"),
                             ]
                         ),

                         TableRow(
                             children: <Widget>[
                              Text("Eiweiß",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                              TextFormField(
                                initialValue: ingredient.protein.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.protein=double.parse(value)}} ,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
                              const Text("g"),
                             ]
                         ),
                         TableRow(
                             children: <Widget>[
                              Text("Gewicht:",style: TextStyle(fontSize: MyProps.fontSize(context, "")) ),
                              TextFormField(
                                initialValue: ingredient.weight.toString(),onChanged: (value) => {if(value!=null&& value.isNotEmpty){ingredient.weight=double.parse(value)}} ,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]), 
                              const Text("g"),
                             ]
                         ),
                       ]
                   ),
                   Padding(
                     padding:  EdgeInsets.all(MyProps.percent(context, 5)),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         ElevatedButton(
                             onPressed: () => {getImg(false)},
                             style: ButtonStyle(
                                 shape:
                                 MaterialStateProperty.all<RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(18.0)))),
                             child: const Text("Bild hochladen")),
                         SizedBox(width: MyProps.itemSize(context, "medium")),
                         Ink(
                           decoration: ShapeDecoration(
                             color: Theme.of(context).colorScheme.primary,
                             shape: const CircleBorder(),
                           ),
                           child: IconButton(
                             icon: const Icon(Icons.add_a_photo),
                             onPressed: () => { getImg(true)},
                           ),
                         ),
                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       ElevatedButton(onPressed: add, child: const Text("Zutat hinzufügen"))
                     ],
                   )
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );

setState(() {
});
}
  textChange(String text, int delay) async {

   setState(() {
     wid=Container(
      margin: EdgeInsets.only(top: MyProps.percent(context, 20)),
      width:MyProps.itemSize(context, "huge"),
      height:MyProps.itemSize(context, "big") ,
      child: const CircularProgressIndicator()
    );
   });
    if (text.length<2) {enterEdit();return null;}
    await Future.delayed( Duration(microseconds: delay));

    iList = await nutriAPI.search(text);
    if(iList.isEmpty) {enterEdit();return null;}
    List<Widget> list= [];
    for(var i=0; i<iList.length;i++){
      list.add(
          Container(
            child: IngredientWidget(
              ingredient: iList[i], onTap:(value)=>{onTap(value)}
              )
          )
      );
    }
    setState(() {
      wid=Expanded(child: ListView(children: list,));
    });
  }
  Widget wid;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar:  const BotNav(index:1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(MyProps.percent(context, 1), MyProps.percent(context, 3), MyProps.percent(context, 1), MyProps.percent(context, 1)),
         child: TextField(
          onChanged: (text){textChange(text,500);},
          onSubmitted:  (text){textChange(text,1);},
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Zutat suchen'),
          ),
        )),
        wid?? Padding(
          padding:EdgeInsets.fromLTRB(0, MyProps.percent(context, 40), 0, 0),  
          child: ElevatedButton(onPressed: enterEdit, 
          child: const Text("Manuell hinzufügen!"))),
      ],
      ),
    );
  }
}

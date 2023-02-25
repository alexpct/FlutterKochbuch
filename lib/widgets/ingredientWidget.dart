//Alex was here
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/widgets/iconbox.dart';

/*class IngredientList extends StatelessWidget{

  final  ValueSetter<Ingredient> onTap;
   IngredientList({super.key,required this.list, required this.onTap} );
wurst(Ingredient ret){onTap(ret);} // aus einem Grund den ich jetzt nicht rausbekommen wollte ging das mal wieder nicht mit Lambdas
List<Ingredient> list;
List<IngredientWidget> children=[];
  @override
  Widget build(BuildContext context) {
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<halt geklapp>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>t");
   // list.forEach((element) {children.add(IngredientWidget(ingredient: element, onTap: wurst(element)));});
    for(var i=0; i<list.length;i++){
      IngredientWidget a = IngredientWidget(ingredient: list[i], onTap:(){});

      children.add(a);
    }
    return(
        ListView(
          children: children
        )
    );

  }

}*/

class IngredientWidget  extends StatelessWidget{

  IngredientWidget({required this.ingredient,required this.onTap }){

  }

  Ingredient ingredient;

  //final  ValueSetter<Ingredient> onTap;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    ImgBox img;/*
    if (ingredient.image!=null) img = ImgBox(label: ingredient.name, onTap:(){onTap(ingredient);}, image: ingredient.image,size: myProps.itemSize(context, "normal"),noMargin: true,noBorder:true);
    else img =  ImgBox(label: ingredient.name, onTap:(){onTap(ingredient);},icon: Icons.kitchen,size: myProps.itemSize(context, "normal"),noMargin: true,noBorder:true);
  */

    if (ingredient.image!=null) img = ImgBox(label: ingredient.name, onTap: onTap, image: ingredient.image,size: myProps.itemSize(context, "normal"),noMargin: true,noBorder:true);
    else img =  ImgBox(label: ingredient.name, onTap:onTap,icon: Icons.kitchen,size: myProps.itemSize(context, "normal"),noMargin: true,noBorder:true);

    String cropedName=ingredient.name;
    if(ingredient.name.length>30) cropedName=ingredient.name.substring(0,30);
    return(
        InkWell(
            onTap: () {
onTap;
            }
            ,
            child:  SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(5),
                height: myProps.itemSize(context, "normal"),
                decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary, width:  1),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  img,  VerticalDivider(
                  width: 20,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),FittedBox(
                      fit: BoxFit.fill,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                        children: [//Text overflow clip geht nicht, susi hilf  mir ^^
                          Text("Name: $cropedName", style:  TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.clip, ),
                       Container(height: myProps.percent(context, 1),),
                        Table(
                              columnWidths:   <int, TableColumnWidth>{ // susi: hier dann auf 4 spalten gehen bzw 5 mit einer leeren Spalte dazwischen
                                0: IntrinsicColumnWidth(),
                                1: FixedColumnWidth(myProps.percent(context, 030))},
    children:<TableRow>[
      TableRow(
          children: <Widget>[Text("Kalorien: "), Text("${ingredient.Calories} ")
          ]
      ),

      TableRow(
          children: <Widget>[Text("Kohlenhydrate: "), Text(ingredient.Carbohydrates.toString()),

          ]
      ),      TableRow(
          children: <Widget>[Text("Fett:: "), Text(ingredient.Fat.toString()),

          ]
      ),
      TableRow(
          children: <Widget>[Text("Eiweiß: "), Text(ingredient.Protein.toString()),

          ]
      ),



          ]
    ),

                        ],
                      )
                    )

                  ],
                ),
              ),




            )
        ));
  }



}
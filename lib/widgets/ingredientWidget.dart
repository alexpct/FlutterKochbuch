//Alex was here
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/widgets/iconbox.dart';



class IngredientWidget  extends StatelessWidget{

  IngredientWidget({Key key,  this.ingredient, this.onTap, this.input=-1, this.onChange, this.quantity=0}) : super(key: key);

  Ingredient ingredient;
  final Function(Ingredient) onTap;
  final Function(int)  onChange;
  int input;
  double quantity;

  proxy(){
    onTap(ingredient);
  }
  @override
  Widget build(BuildContext context) {
    ImgBox img;
  
    if (ingredient.image!=null) {
      img = ImgBox(
        label: ingredient.name, 
        onTap:proxy, 
        image: ingredient.image,
        size: MyProps.itemSize(context, "normal"),
        noMargin: true,noBorder:true);
    } else {
      img =  ImgBox(
        label: ingredient.name, 
        onTap:proxy,
        icon: Icons.kitchen,
        size: MyProps.itemSize(context, "normal"),
        noMargin: true,noBorder:true);
    }

    String cropedName=ingredient.name;
    if(ingredient.name.length>30) cropedName=ingredient.name.substring(0,30);
    return(
        InkWell(
            onTap: () {
              proxy();
            },
            child:  SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(5),
                height: MyProps.itemSize(context, "normal"),
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
                      child:Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text("Name: $cropedName", style:  const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.clip, ),
                           Container(height: MyProps.percent(context, 1),),
                            Table(
                                  columnWidths:   <int, TableColumnWidth>{
                                    0: const IntrinsicColumnWidth(),
                                    1: FixedColumnWidth(MyProps.percent(context, 030))},
                              children:<TableRow>[
                                TableRow(
                                    children: <Widget>[const Text("Kalorien: "), Text("${ingredient.calories} ")
                                    ]
                                ),

                                TableRow(
                                    children: <Widget>[const Text("Kohlenhydrate: "), Text(ingredient.carbohydrates.toString()),

                                    ]
                                ),      TableRow(
                                    children: <Widget>[const Text("Fett:: "), Text(ingredient.fat.toString()),

                                    ]
                                ),
                                TableRow(
                                    children: <Widget>[const Text("Eiwei??: "), Text(ingredient.protein.toString()),

                                    ]
                                ),
                              ]
                            )]
                          ),
                          Column(
                            children: [ if(input>=0 || quantity!=0) const Text("Menge:"),
                          if(input>=0) Container(width: MyProps.percent(context, 15), height: MyProps.percent(context, 10), child: TextFormField(initialValue:input.toString() , textAlign: TextAlign.center, onChanged: (value) =>onChange(int.parse(value)),keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                           ),
                          ),
                          if(input<0 && quantity!=0) Container(width: MyProps.percent(context, 15), height: MyProps.percent(context, 10), child:Text(quantity.toString()),),
                           ], 
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
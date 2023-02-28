//Alex was here
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class newRecipe extends StatefulWidget {
  const newRecipe();


  final String title="Neues Rezept";

  @override
  State<newRecipe> createState() => _newRecipeState();
}
dbHelper db=dbHelper();


class growBox{
  static double size=0;
  static int _max=40;
  static bool _toBig(BuildContext context){
    if(size>=myProps.percent(context, 50)) return false;
    return true;
  }


  static grow(BuildContext context){if(_toBig(context))size+=myProps.percent(context, 15);print(size);}
  static shrink(BuildContext context){size-=myProps.percent(context, 15);}
}
class _newRecipeState extends State<newRecipe> {



  List<Ingredient> ingredientList=[];



  addIngredient(){
    print("wurst");
    ingredientList.add(Ingredient(name: "wurst", Calories: 1337, pieceGood: true));
   setState(() {
     growBox.grow(context);
   });

  }
List<Widget> widList=[];
  @override
  Widget build(BuildContext context) {
Color primaryColor= Theme.of(context).colorScheme.primary;
String currentText="wolf";

Widget catText =  SimpleAutoCompleteTextField(
  decoration: InputDecoration(helperText:"Kategorie"),
  controller: TextEditingController(text: ""),
  suggestions: ['wurst','käse','wurm'],
  textChanged: (text) =>  text,
  clearOnSubmit: true,
  textSubmitted: (text) => setState(() {
    if (text != "") {

    }
  }),
);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        bottomNavigationBar:  BotNav(Index:2),
        body:
        SingleChildScrollView(
         child: Column(
            children: [

              Padding(
                padding:  EdgeInsets.fromLTRB(myProps.percent(context, 3), myProps.percent(context, 5), myProps.percent(context, 3), 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kategorie:", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                      Container(width:myProps.percent(context, 30), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Container(width: 50,height: 50, color: Colors.red,),Text("Käse")])),


                    ]
                ),

              ),
             Padding(
               padding:  EdgeInsets.fromLTRB(myProps.percent(context, 3), myProps.percent(context, 5), myProps.percent(context, 3), 0),
               child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Zutaten", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                 InkWell(

                   child: Icon(Icons.add, color:primaryColor ,size: myProps.itemSize(context, "tiny"),),
                   onTap: addIngredient,
                 )

               ]
         ),
             ),
              Divider(
                thickness:1,
                indent: 5,
                endIndent: 5,
                color: primaryColor,
              ),
    ConstrainedBox(
    constraints: BoxConstraints(
    maxHeight: growBox.size,// eigentlich reicht hier ein conteiner, aber die constraintbox ist jetzt da
    ),
    child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: ingredientList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = ingredientList[index];

          return ListTile(title: Text(item.name), trailing: Wrap(
              spacing: 1,  // space between two icons
              children: <Widget>[
                IconButton(onPressed:()=>setState(() {
                  ingredientList.removeAt(index);growBox.shrink(context);
                }), icon: Icon(Icons.remove)),

              ]
          )
          );

        }


    ),
    ),


  Padding(
    padding:  EdgeInsets.all(myProps.percent(context, 2)),
    child: TextField(minLines: 20,maxLines: 20,decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'Beschreibung',
      floatingLabelBehavior: FloatingLabelBehavior.always,contentPadding: EdgeInsets.all(myProps.percent(context, 5)),  )  ,),
  ),
              Divider(
                thickness:1,
                indent: 5,
                endIndent: 5,
                  color: primaryColor,
              ),



            ],

          )



        )


    );
  }


}

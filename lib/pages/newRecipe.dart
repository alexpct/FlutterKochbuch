//Alex was here
import 'package:flutter/material.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';

class newRecipe extends StatefulWidget {
  const newRecipe({super.key});


  final String title="Neues Rezept";

  @override
  State<newRecipe> createState() => _newRecipeState();
}
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

  @override
  Widget build(BuildContext context) {
Color primaryColor= Theme.of(context).colorScheme.primary;
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

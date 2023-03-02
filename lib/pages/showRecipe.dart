import 'package:flutter/material.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/pages/snake.dart';
import 'package:kochbuch/widgets/imageGallery.dart';

import '../helper/dbhelper.dart';
import '../helper/objects.dart';
import '../widgets/ShortLoadingScreen.dart';
import '../widgets/botnav.dart';
import '../widgets/ingredientWidget.dart';

class ShowRecipe extends StatefulWidget {
   ShowRecipe({Key key, this.recipe, this.byName }) : super(key: key);

  Recipe recipe;
  String byName;
  String title ="Rezept anzeigen";




   @override
  State<ShowRecipe> createState() => _ShowRecipeState();
}
class _ShowRecipeState extends State<ShowRecipe> {
  Recipe recipe;
  bool boot=true;
  Widget tabBody;
  String title="Rezept anzeigen";



  @override
  void initState() {
    super.initState();
    init();
    }


  init() async {
    final db = await dbHelper();
if(widget.recipe!=null) recipe=widget.recipe;
if(widget.byName!=null) recipe =  await db.getRecipe(widget.byName);
title=recipe.name;

tabLeft();

setState(() {
  boot=false;
});



  }

  double leftB;
  double rightB;
  tabLeft(){
    tabBody = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ImageGallery(images: recipe.images,),
    );





    setState(() {
      leftB=MyProps.percent(context, 1);
      rightB=MyProps.percent(context, 0.5);

    });
  }
  tabRight(){

    tabBody = ListView.builder(
      padding:  EdgeInsets.all(MyProps.percent(context, 3)),
      itemCount: recipe.ingredients.length,
      itemBuilder: (BuildContext context, int index) {
        final item = recipe.ingredients[index];

        return  FittedBox(fit: BoxFit.contain ,
            child: IngredientWidget(ingredient:item, quantity: item.quantity.toDouble() ,onTap:(value)=>{},
                onChange: (value) => {setState((){item.quantity = value;})} ));

      },
      shrinkWrap: true,


    )
    ;
    setState(() {
      leftB=MyProps.percent(context, 0.5);
      rightB=MyProps.percent(context, 1);

    });
  }


  @override
  Widget build(BuildContext context) {
   if (boot) return ShortLoadingScreen(title: title,index: 1,);
Color primaryColor=Theme.of(context).primaryColor;



   return Scaffold(
       appBar: AppBar(
         // Here we take the value from the MyHomePage object that was created by
         // the App.build method, and use it to set our appbar title.
         title: Text(title),

         actions: [ElevatedButton(onPressed: ()=>{Navigator.push(
           context,
           PageRouteBuilder(
             pageBuilder: (_, __, ___) =>  SnakeGame(),
             transitionDuration: const Duration(seconds: 0),
           ))}, child:  Text("Zeit: "+recipe.time.toString()+" Minuten"))],
       ),



       bottomNavigationBar:  const BotNav(Index:1),

       body:
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: tabLeft,
                            child: Container(

                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor,width: leftB )

                              ),
                              padding: EdgeInsets.all(MyProps.percent(context, 3)+rightB),
                              child: Center(child: Text("Bilder")),


                            ),
                          ),
                        ),                         Expanded(
                          child: InkWell(
                            onTap: tabRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor,width: rightB )

                              ),
                              padding: EdgeInsets.all(MyProps.percent(context, 3)+leftB),
                              child: Center(child: Text("Zutaten")),


                            ),
                          ),
                        )
                      ],
                    ),

                    Expanded(
                      child:
                         tabBody,
                      ),
                    Divider(
                      thickness:1,
                      indent: 5,
                      endIndent: 5,
                      color: primaryColor,
                    ),



                  ],
                )
              ),
              Expanded(
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(MyProps.percent(context, 2)),
padding: EdgeInsets.all(MyProps.percent(context, 3)),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor,width:MyProps.percent(context, 0.6) )


                          ),
                          child: SingleChildScrollView(child: Text(recipe.text)),


                        ),
                      ),
                    ],
                  )
              ),
            ],
          )


   );
  }


}
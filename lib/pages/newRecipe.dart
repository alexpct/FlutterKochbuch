//Alex was here
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/pages/addCat.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../helper/navi.dart';
import '../widgets/botnav.dart';
import '../widgets/iconbox.dart';
import '../widgets/imageGallery.dart';
import 'NewIngredient.dart';

class newRecipe extends StatefulWidget {
   newRecipe({this.recipe});


  final String title="Neues Rezept";
  Recipe recipe;
  @override
  State<newRecipe> createState() => _newRecipeState();
}

class _newRecipeState extends State<newRecipe> {

@override
  void initState()  {

    super.initState();

 if(widget.recipe!=null)  {recipe= widget.recipe;update=true;initTime=widget.recipe.Time.toString();oldName=widget.recipe.Name;}

init();
  }
Widget ingAutoInput;
Widget catAutoInput ;
bool boot=true;
dbHelper db = dbHelper();
Recipe recipe = new Recipe();
List<Ingredient> ingList =[];
List<String> ingNames=[];
List<String> catNames=[];
AppBar  appBar;
String initTime="";
String oldName;
bool update=false;
init() async {
    boot=true;

    appBar= AppBar(
      title: Text("Rezept hinzufügen"),
      actions: [ElevatedButton(onPressed: add, child: const Text("+"))],
    );

    await db.getName("Ingredients").then((value) => ingNames=value).then((value) =>
    {      ingAutoInput =Expanded(
        child: SimpleAutoCompleteTextField(
          controller: TextEditingController(text: ""),
          suggestions: ingNames,
          textChanged: (text) =>  text,
          clearOnSubmit: true,
          textSubmitted: (name) => addIngredient(name),
        ),
      )
    });
    await db.getName("Category").then((value) => catNames=value).then((value) =>
    {      catAutoInput =Expanded(
      child: SimpleAutoCompleteTextField(
        controller: TextEditingController(text: ""),
        suggestions: catNames,
        textChanged: (text) =>  text,
        clearOnSubmit: true,
        textSubmitted: (name) => setState((){recipe.cats.add(name);}),
      ),
    )
    });


    setState(() {
boot=false;
    });
  }


  addIngredient(String name) async {
await db.getIng(name).then((value) =>    setState(() { recipe.ingredients.add(value.first);}));
  }
  add() async {
    String fail;
    if(!update)oldName=recipe.Name;
    fail = await recipe.save(update,oldName);
    if(fail!=null)setState(() {
      appBar=failbar(context, fail);
    });
  }


  @override
  Widget build(BuildContext context) {
Color primaryColor= Theme.of(context).colorScheme.primary;


     if(boot) return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar:  BotNav(Index:2),

  body: Center(

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(child: CircularProgressIndicator(strokeWidth: 5),width: myProps.itemSize(context, "fill"), height:  myProps.itemSize(context, "huge") ) , Text("Wenn du das lesen kannnst warst du schnell oder es lief was schief"),
      ],
    ),
  ),
);
    return Scaffold(
        appBar: appBar,
        bottomNavigationBar:  BotNav(Index:2),
        floatingActionButton:  FloatingActionButton.extended(
      onPressed: () {
        add();
      },
      label: update ? Text("Kategorie bearbeiten") : Text("Kategorie hinzufügen"),
    ),
        body:
        SingleChildScrollView(
         child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(myProps.percent(context, 3), myProps.percent(context, 5), myProps.percent(context, 3), 0),
                child:

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name:", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                      Expanded(child: TextFormField(initialValue: widget.recipe?.Name  , onChanged:(value)=> setState(()=>{recipe.Name=value}) ,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Zeit:", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                          SizedBox(width: myProps.percent(context, 10), child: TextFormField( initialValue: initTime ,onChanged: (value) =>{setState(()=>recipe.Time=int.parse(value))},keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],),)
                        ],
                      )

                    ]
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(myProps.percent(context, 3), myProps.percent(context, 5), myProps.percent(context, 3), 0),
                child:

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kategorie(en):", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                      catAutoInput,


                      InkWell(


                        child: Icon(Icons.fiber_new_sharp, color:primaryColor ,size: myProps.itemSize(context, "tiny"),),
                        onTap:(){
                          setState(() {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => addCat(),
                                  transitionDuration: const Duration(seconds: 0),
                                )).then((value) => init()) ;

                          });
                        },
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
                    maxHeight: myProps.percent(context, 80), minHeight: 0
                ),
                child: ListView.builder(
                  padding:  EdgeInsets.all(myProps.percent(context, 3)),
                  itemCount:recipe.cats.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item =recipe.cats[index];

                    return  ListTile(title: Text(item), trailing: Wrap(
                        spacing: 1,  // space between two icons
                        children: <Widget>[
                          IconButton(onPressed: ()=> setState((){recipe.cats.removeAt(index);}) , icon: Icon(Icons.delete))

                        ]
                    )
                    );

                  },
                  shrinkWrap: true,


                ),
              ),
             Padding(
               padding:  EdgeInsets.fromLTRB(myProps.percent(context, 3), myProps.percent(context, 5), myProps.percent(context, 3), 0),
               child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                Text("Zutaten:", style: TextStyle(color: primaryColor,fontSize: myProps.fontSize(context, "")),),
                 ingAutoInput,

                 InkWell(


                   child: Icon(Icons.fiber_new_sharp, color:primaryColor ,size: myProps.itemSize(context, "tiny"),),
                   onTap:(){
                     setState(() {
                       Navigator.push(
                           context,
                           PageRouteBuilder(
                             pageBuilder: (_, __, ___) => NewIngredient(),
                             transitionDuration: const Duration(seconds: 0),
                           )).then((value) => init()) ;

                     });
                   },
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
        maxHeight: myProps.percent(context, 80), minHeight: 0
    ),
    child: ListView.builder(
        padding:  EdgeInsets.all(myProps.percent(context, 3)),
        itemCount: recipe.ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          final item = recipe.ingredients[index];

          return  FittedBox(fit: BoxFit.contain ,
              child: IngredientWidget(ingredient:item, input: item.quantity ,onTap:(value)=>setState((){ recipe.ingredients.removeAt(index);}),
              onChange: (value) => {setState((){item.quantity = value;})} ));

        },
      shrinkWrap: true,


    ),
    ),


  Padding(
    padding:  EdgeInsets.all(myProps.percent(context, 2)),
    child: TextFormField(initialValue: recipe.Text??="" , onChanged:(value)=>recipe.Text=value,minLines: 5,maxLines: 20,decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'Beschreibung',
      floatingLabelBehavior: FloatingLabelBehavior.always,contentPadding: EdgeInsets.all(myProps.percent(context, 5)),  )  ,),
  ),
              Divider(
                thickness:1,
                indent: 5,
                endIndent: 5,
                  color: primaryColor,
              ),

              Row(
                children: [
Expanded(child: ImageGallery(images: recipe.images, editable: true,onChange: (value) => setState(()=>{recipe.images=value}),))
                ],
              )








              , Container(height: myProps.percent(context, 30),)
            ],

          )



        )


    );
  }


}

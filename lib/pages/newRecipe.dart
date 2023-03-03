//Alex was here  ///
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuch/helper/dbhelper.dart';
import 'package:kochbuch/helper/objects.dart';
import 'package:kochbuch/helper/tinyHelpers.dart';
import 'package:kochbuch/pages/addCat.dart';
import 'package:kochbuch/widgets/ingredientWidget.dart';

import '../widgets/ShortLoadingScreen.dart';
import '../widgets/botnav.dart';
import '../widgets/imageGallery.dart';
import 'NewIngredient.dart';

class NewRecipe extends StatefulWidget {
   NewRecipe( {Key key, this.recipe}) : super(key: key);

  final String title="Neues Rezept";
  Recipe recipe;
  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {

@override
  void initState() {

    super.initState();

 if(widget.recipe!=null){
  recipe= widget.recipe;
  update=true;initTime=widget.recipe.time.toString();
  oldName=widget.recipe.name;
  }
  init();
  }

  Widget ingAutoInput;
  Widget catAutoInput ;
  bool boot=true;
  DbHelper db = DbHelper();
  Recipe recipe = Recipe();
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
      title: const Text("Rezept hinzufügen"),
      actions: [ElevatedButton(onPressed: add, child: const Text("+"))],
    );

    await db.getName("Ingredients").then((value) => ingNames=value).then((value) =>
    {      ingAutoInput =Expanded(
        child: SimpleAutoCompleteTextField(
          controller: TextEditingController(text: ""),
          suggestions: ingNames,
          textChanged: (text) =>  text,
          clearOnSubmit: true,
          textSubmitted: (name) => addIngredient(name), key: null,
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
        textSubmitted: (name) => setState((){recipe.cats.add(name);}), key: null,
      ),
    )
    });


    setState(() {
      boot=false;
    });
  }


  addIngredient(String name) async {
await db.getIng(name).then((value) =>  setState(() { recipe.ingredients.add(value.first);}));
  }
  add() async {
    String fail;
    if(!update)oldName=recipe.name;
    fail = await recipe.save(update,oldName);
    if(fail!=null) {
      setState(() {
      appBar=failbar(context, fail);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
Color primaryColor= Theme.of(context).colorScheme.primary;


    if (boot) return ShortLoadingScreen(title: widget.title,index: 0,);
    return Scaffold(
        appBar: appBar,
        bottomNavigationBar:  const BotNav(index:2),
        floatingActionButton:  FloatingActionButton.extended(
      onPressed: () {
        add();
      },
      label: update ? const Text("Rezept bearbeiten") : const Text("Rezept hinzufügen"),
    ),
        body:
        SingleChildScrollView(
         child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(MyProps.percent(context, 3), MyProps.percent(context, 5), MyProps.percent(context, 3), 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name:", style: TextStyle(color: primaryColor,fontSize: MyProps.fontSize(context, "")),),
                      Expanded(child: TextFormField(initialValue: widget.recipe?.name  , onChanged:(value)=> setState(()=>{recipe.name=value}) ,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Zeit:", style: TextStyle(color: primaryColor,fontSize: MyProps.fontSize(context, "")),),
                          SizedBox(width: MyProps.percent(context, 10), child: TextFormField( initialValue: initTime ,onChanged: (value) =>{setState(()=>recipe.time=int.parse(value))},keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],),)
                        ],
                      )
                    ]
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(MyProps.percent(context, 3), MyProps.percent(context, 5), MyProps.percent(context, 3), 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kategorie(en):", style: TextStyle(color: primaryColor,fontSize: MyProps.fontSize(context, "")),),
                      catAutoInput,
                      InkWell(
                        child: Icon(Icons.fiber_new_sharp, color:primaryColor ,size: MyProps.itemSize(context, "tiny"),),
                        onTap:(){
                          setState(() {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => AdEdCat(),
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
                    maxHeight: MyProps.percent(context, 80), minHeight: 0
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding:  EdgeInsets.all(MyProps.percent(context, 3)),
                  itemCount:recipe.cats.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item =recipe.cats[index];

                    return  ListTile(title: Text(item), trailing: Wrap(
                        spacing: 1, 
                        children: <Widget>[
                          IconButton(onPressed: ()=> setState((){recipe.cats.removeAt(index);}) , icon: const Icon(Icons.delete))
                        ]
                    )
                    );
                  },
                ),
              ),
             Padding(
               padding:  EdgeInsets.fromLTRB(MyProps.percent(context, 3), MyProps.percent(context, 5), MyProps.percent(context, 3), 0),
               child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                Text("Zutaten:", style: TextStyle(color: primaryColor,fontSize: MyProps.fontSize(context, "")),),
                 ingAutoInput,
                 InkWell(
                   child: Icon(Icons.fiber_new_sharp, color:primaryColor ,size: MyProps.itemSize(context, "tiny"),),
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
                maxHeight: MyProps.percent(context, 80), minHeight: 0
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding:  EdgeInsets.all(MyProps.percent(context, 3)),
                itemCount: recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = recipe.ingredients[index];
                    return  FittedBox(fit: BoxFit.contain ,
                        child: IngredientWidget(
                          ingredient:item, 
                          input: item.quantity ,
                          onTap:(value)=>setState((){ recipe.ingredients.removeAt(index);}),
                          onChange: (value) => {setState((){item.quantity = value;})} 
                        )
                     );
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(MyProps.percent(context, 2)),
                child: TextFormField(
                  initialValue: recipe.text??="" , 
                  onChanged:(value)=>recipe.text=value,
                  minLines: 5,
                  maxLines: 20,
                  decoration: InputDecoration(border: const OutlineInputBorder(),
                   labelText: 'Beschreibung',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.all(MyProps.percent(context, 5)), 
                   ),
                 ),
              ),
              Divider(
                 thickness:1,
                 indent: 5,
                 endIndent: 5,
                 color: primaryColor,
              ),
              Row(
                children: [
                  Expanded(
                    child: ImageGallery(
                     images: recipe.images, 
                     editable: true,
                     onChange: (value) => setState(()=>{recipe.images=value}),
                    )
                  )
                ],
              ), 
              Container(
                height: MyProps.percent(context, 30),
              )
            ],
          )
        )
    );
  }
}

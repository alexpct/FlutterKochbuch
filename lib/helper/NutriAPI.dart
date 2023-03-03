 ///
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:kochbuch/helper/objects.dart';

class NutriAPI{
int _runNum=0;
List<Ingredient> lastRet=[];
Future<Ingredient> _buildIngredient(Map<String, dynamic> ing) async {
    double calories=1337;
    double fat=1337;
    double protein=1337;
    double carbohydrates=1337;
    Uint8List  bytes;
    double weight= ing['serving_weight_grams']/1;

    String name=ing['food_name'];
    String url =ing['photo']['thumb'];

    final get = await http.get(Uri.parse(url));
    bytes = get.bodyBytes;
    List  run =  ing['full_nutrients']; 
    
    for (var i=0; i <run.length;i++){
      switch (run[i]['attr_id']){
        case 208: calories=run[i]['value']/1; {}break;
        case 205: carbohydrates=run[i]['value']/1; {}break;
        case 204: fat=run[i]['value']/1; {}break;
        case 203: protein=run[i]['value']/1; {}break;
      }
    }
    return Future<Ingredient>.value(Ingredient(name: name, calories: calories, fat: fat, protein: protein, carbohydrates: carbohydrates,weight: weight, bytes: bytes, pieceGood: true));

  }
  Future<List<Ingredient>>  search(String query ) async {
    int thisRun =_runNum.toInt();
    thisRun++;
    String uri = "https://trackapi.nutritionix.com/v2/search/instant?query=$query&locale=de_DE&branded=false&detailed=true";
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'x-app-id': '7b773536',
        'x-app-key': '7ff5548603c326b1bca3af594e3f437b',
      },
    );
    var decode = jsonDecode(response.body);
    List<Ingredient> ret=[];
    for(var i=0;i<decode['common'].length && i<5; i++){ 
      Ingredient a =await _buildIngredient(decode['common'][i]);
      ret.add(a);
    }
    if(thisRun>=_runNum)lastRet=ret;
    _runNum=thisRun;
    return  Future<List<Ingredient>>.value(lastRet);

  }

}
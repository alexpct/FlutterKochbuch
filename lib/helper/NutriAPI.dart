
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kochbuch/helper/objects.dart';


// Nur eine Funktion in der Klasse ist doof, aber da sollen noch die restlichen FUnktionen von Nutritionix rein

class NutriAPI{

  _buildIngredient(Map<String, dynamic> ing) async {
    double Calories=1337;
    double Fat=1337;
    double Protein=1337;
    double Carbohydrates=1337;
    Uint8List?  bytes;
    double calFactor;

    String name=ing['food_name'];
    String url =ing['photo']['thumb'];

    final get = await http.get(Uri.parse(url));
    bytes = get.bodyBytes;
    var run =  ing['full_nutrients']; //jaja hier kommt ein klassischer for loop, ich weiß wir nutzen heute alle 'ne map
    for (var i=0; i <run.length;i++){
      switch (run[i]['attr_id']){
        case 208: Calories=run[i]['value']/1;break;
        case 205: Carbohydrates=run[i]['value']/1;break;
        case 204: Fat=run[i]['value']/1;break;
        case 203: Protein=run[i]['value']/1;break;
      }

      calFactor = 100/(ing['serving_weight_grams']*ing['serving_qty']);
      Calories*=calFactor;
    }

    return Ingredient(name: name, Calories: Calories, Fat: Fat, Protein: Protein, Carbohydrates: Carbohydrates, bytes: bytes);

  }
  Future<List<Ingredient>>  search(String query ) async {
    String URI = "https://trackapi.nutritionix.com/v2/search/instant?query=$query&locale=de_DE&branded=false&detailed=true";

    final response = await http.get(
      Uri.parse(URI),
      headers: {
        'x-app-id': '7b773536',
        'x-app-key': '7ff5548603c326b1bca3af594e3f437b',
      },
    );
    var decode = jsonDecode(response.body);
    List<Ingredient> ret=[];
    //decode['common'].forEach((e) async =>ret.add(await _buildIngredient(e)));
    for(var i=0;i<decode['common'].length; i++){
      Ingredient a =await _buildIngredient(decode['common'][i]);
      ret.add(a);
    }

    return  Future<List<Ingredient>>.value(ret);

  }

}
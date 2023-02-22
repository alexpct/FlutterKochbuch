
import 'dart:convert';

import 'package:http/http.dart' as http;


// Nur eine Funktion in der Klasse ist doof, aber da sollen noch die restlichen FUnktionen von Nutritionix rein

class NutriAPI{


  search(String query ) async {
    String URI = "https://trackapi.nutritionix.com/v2/search/instant?query=$query&locale=de_DE&branded=false&detailed=true";

    final response = await http.get(
      Uri.parse(URI),
      headers: {
        'x-app-id': '7b773536',
        'x-app-key': '7ff5548603c326b1bca3af594e3f437b',
      },
    );
    var decode = jsonDecode(response.body);
    print("--------------------------");

    decode['common'].forEach((e)=>print(e['full_nutrients'][1]));

  }

}
//susi was sadly here
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';


void main() => runApp(const ingredients());

class ingredients extends StatefulWidget {
  const ingredients({super.key});

  @override
  State<ingredients> createState() => _ingredientsState();
  
}

class _ingredientsState extends State<ingredients> {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zutaten hinzufügen/editieren'),
        ),
        body: Center(
          child:Column(
            children: const [
            //name_ingredients(), old
            //typeheadsearch(), new
            category_list(),
            nutrition_table(),           
             ],)      
        ),
      ),
    );
    
  }
}
 //api fetch :( WIP

 class food {
  int food_name;
  String nf_calories;
  String brand_name;


  food(
      {required this.food_name,
      required this.nf_calories,
      required this.brand_name});

  factory food.fromJson(Map<String, dynamic> json) {
    return food(
        food_name: json['food_name'],
        nf_calories: json['nf_calories'],
        brand_name: json['brand_name']);
  }


}


Future<List<food>> fetchUsers() async {
    String apiUrl = "https://trackapi.nutritionix.com/v2/search/instant";
    var response = await http.get(Uri.parse(apiUrl),headers: {
    HttpHeaders.authorizationHeader:
        '7ff5548603c326b1bca3af594e3f437b'
  },);
    return (json.decode(response.body)['branded'] as List)
        .map((e) => food.fromJson(e))
        .toList();
  //
}



//widgets

/*
//old autocom
class name_ingredients extends StatefulWidget {
  const name_ingredients({super.key});

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  State<name_ingredients> createState() => _name_ingredientsState();
}

class _name_ingredientsState extends State<name_ingredients> {

  @override
  Widget build(BuildContext context) {
    
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }else
        return name_ingredients._kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
/////// */

//typehead
class typeheadsearch extends StatelessWidget {


  const typeheadsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
  textFieldConfiguration: TextFieldConfiguration(
    autofocus: true,
    style: DefaultTextStyle.of(context).style.copyWith(
      fontStyle: FontStyle.italic
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder()
    )
  ),
  suggestionsCallback: (pattern) async {
    return await fetchUsers();
  },
  itemBuilder: (context, suggestion) {
    return ListTile(
      leading: Icon(Icons.shopping_cart)
    );
  },
  onSuggestionSelected: (suggestion) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => typeheadsearch()
    ));
  },
);
  }}

//

class category_list extends StatefulWidget {
  const category_list({super.key});

  @override
  State<category_list> createState() => _category_listState();
}

class _category_listState extends State<category_list> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        ExpansionTile(
          title: Text('Kategorien'),        
          children: <Widget>[
            ListTile(title: Text('Kategorie1')),
          ],
        ),
      ],
    );
  }
}

//table

class nutrition_table extends StatelessWidget {
  const nutrition_table({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Nährwerte',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Wert pro 100g',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Energie')),
            DataCell(Text('19')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Fett')),
            DataCell(Text('43')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Kohlenhydrate')),
            DataCell(Text('27')),
          ],
        ),
         DataRow(
          cells: <DataCell>[
            DataCell(Text('Zucker')),
            DataCell(Text('27')),
          ],
        ), DataRow(
          cells: <DataCell>[
            DataCell(Text('Eiweiß')),
            DataCell(Text('27')),
          ],
        ), DataRow(
          cells: <DataCell>[
            DataCell(Text('Salz')),
            DataCell(Text('27')),
          ],
        ),
      ],
    );
  }
}


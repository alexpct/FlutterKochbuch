import 'package:flutter/material.dart';

import '../helper/objects.dart';

class ShowRecipe extends StatefulWidget {
   ShowRecipe({Key key, this.recipe }) : super(key: key);

  Recipe recipe;

  @override
  State<ShowRecipe> createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
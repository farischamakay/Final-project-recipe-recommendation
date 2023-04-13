import 'package:cooking_tutorial_application/models/recipe_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class FavoriteBtn extends StatelessWidget {
  final RecipeRecom info;
  const FavoriteBtn({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder<Box>(
        valueListenable: Hive.box("Favorite").listenable(),
        builder: (context, box, child) {
          bool isfavorite = box.containsKey(info.recipeId);
          if (isfavorite) {
            return FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                final box = Hive.box("Favorite");
                box.delete(info.recipeId);
              },
              child: const Icon(
                Icons.favorite,
              ),
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {
                final box = Hive.box("Favorite");
                box.put(info.recipeId, info.toJson());
              },
              child: const Icon(
                Icons.favorite,
              ),
            );
          }
        },
      ),
    );
  }
}

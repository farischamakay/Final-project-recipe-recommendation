import 'dart:convert';

class RecipeRecom {
  RecipeRecom({
    required this.recipeId,
    required this.name,
    required this.description,
    required this.country,
    required this.category,
    required this.cookTime,
    required this.ingredients,
    required this.instructions,
    required this.author,
    required this.tags,
  });

  int recipeId;
  String name;
  String description;
  String country;
  String category;
  int cookTime;
  String ingredients;
  String instructions;
  String author;
  String tags;

  factory RecipeRecom.fromJson(Map<String, dynamic> json) => RecipeRecom(
        recipeId: json["recipe_id"],
        name: json["name"],
        description: json["description"],
        country: json["country"],
        category: json["category"],
        cookTime: json["cook_time"],
        ingredients: json["ingredients"],
        instructions: json["instructions"],
        author: json["author"],
        tags: json["tags"],
      );

  toJson() => {
        'recipe_id': recipeId,
        'name': name,
        'description': description,
        'country': country,
        'category': category,
        'cook_time': cookTime,
        'instructions': instructions,
        'author': author,
        'ingredients': ingredients,
        'tags': tags,
      };
}

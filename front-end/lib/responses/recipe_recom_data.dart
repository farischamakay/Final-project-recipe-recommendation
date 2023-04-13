import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_recommendation.dart';

class RecipeDataRecomResponse {
  final _recomUrl = 'http://10.0.2.2:5000/recomendation';
  final _popularUrl = 'http://10.0.2.2:5000/popular';
  final _moreRecomUrl = 'http://10.0.2.2:5000/morerecomendation';
  final _morepopularUrl = 'http://10.0.2.2:5000/morepopular';
  final _ingredients = 'http://10.0.2.2:5000/ingredients';
  final _similarity = 'http://10.0.2.2:5000/newrecommendation';

  Future getPopularRecipe() async {
    try {
      final response = await http.get(Uri.parse(_popularUrl));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> popular =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return popular;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getRecomRecipe() async {
    try {
      final response = await http.get(Uri.parse(_recomUrl));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> recom =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return recom;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getSimilarityRecipe() async {
    try {
      final response = await http.get(Uri.parse(_similarity));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> popular =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return popular;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMoreRecomRecipe() async {
    try {
      final response = await http.get(Uri.parse(_moreRecomUrl));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> moreRecom =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return moreRecom;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMorePopularRecipe() async {
    try {
      final response = await http.get(Uri.parse(_morepopularUrl));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> morePopular =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return morePopular;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getRecommendationRecipeByIngredients() async {
    try {
      final response = await http.get(Uri.parse(_ingredients));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<RecipeRecom> ingredients =
            it.map((e) => RecipeRecom.fromJson(e)).toList();
        return ingredients;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

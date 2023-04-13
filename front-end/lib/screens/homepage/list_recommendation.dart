import 'package:flutter/material.dart';
import '../../models/recipe_recommendation.dart';
import '../../responses/recipe_recom_data.dart';
import '../recipe_view/recipeView.dart';

class ListRecommendation extends StatefulWidget {
  const ListRecommendation({super.key});

  @override
  State<ListRecommendation> createState() => _ListRecommendationState();
}

class _ListRecommendationState extends State<ListRecommendation> {
  late bool _isLoading;
  List<RecipeRecom> listByIngredientsRecom = [];
  RecipeDataRecomResponse recipeResponse = RecipeDataRecomResponse();

  getRecomByIngredientsRecipe() async {
    listByIngredientsRecom =
        await recipeResponse.getRecommendationRecipeByIngredients();
    setState(() {});
  }

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    getRecomByIngredientsRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff1bb274),
          title: const Text(
            "List of Recommendation Recipes",
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView(
                    padding: EdgeInsets.all(5),
                    children: List.generate(
                      listByIngredientsRecom.length,
                      (index) => GestureDetector(
                        child: Card(
                          shadowColor: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          color: Colors.grey[100],
                          child: ListTile(
                            leading: Image.asset('assets/bg.jpg'),
                            title: Text(
                              listByIngredientsRecom[index].name.toUpperCase(),
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            subtitle: Text(
                                "Ready in ${listByIngredientsRecom[index].cookTime} Minutes"),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetail(
                                    info: listByIngredientsRecom[index]))),
                      ),
                    )),
              )));
  }
}

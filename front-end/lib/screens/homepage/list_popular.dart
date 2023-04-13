import 'package:flutter/material.dart';
import '../../models/recipe_recommendation.dart';
import '../../responses/recipe_recom_data.dart';

class ListMorePopular extends StatefulWidget {
  const ListMorePopular({super.key});

  @override
  State<ListMorePopular> createState() => _ListMorePopularState();
}

class _ListMorePopularState extends State<ListMorePopular> {
  late bool _isLoading;
  List<RecipeRecom> listMorePopular = [];
  RecipeDataRecomResponse recipeResponse = RecipeDataRecomResponse();

  getMorePopularRecipe() async {
    listMorePopular = await recipeResponse.getMorePopularRecipe();
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
    getMorePopularRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff1bb274),
          title: const Text(
            "List of Popular Recipes",
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, indext) {
                      return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5,
                                    spreadRadius: 5)
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: Image.asset(
                                  'assets/bg.jpg',
                                ),
                              ),
                              Text(
                                listMorePopular[indext].name.toUpperCase(),
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                              Text(
                                "Ready in ${listMorePopular[indext].cookTime} Minutes",
                                // style:
                                //     const TextStyle(color: Colors.redAccent),
                              ),
                              Text(
                                "By ${listMorePopular[indext].author}",
                                // style:
                                //     const TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 7,
                      );
                    },
                    itemCount: listMorePopular.length),
              ));
  }
}

import 'package:cooking_tutorial_application/models/recipe_recommendation.dart';
import 'package:cooking_tutorial_application/screens/recipe_view/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../animation/animation.dart';
import '../../responses/recipe_recom_data.dart';

class RecipeDetail extends StatefulWidget {
  static const nameRoute = '/viewRecipe';
  final RecipeRecom info;

  const RecipeDetail({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  List<RecipeRecom> listSimilarity = [];
  RecipeDataRecomResponse recipeResponse = RecipeDataRecomResponse();

  getRecomNewRecipe() async {
    listSimilarity = await recipeResponse.getSimilarityRecipe();
    setState(() {});
  }

  @override
  void initState() {
    getRecomNewRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: RecipeAppBar(expandedHeight: 300, info: widget.info),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DelayedDisplay(
                    delay: const Duration(microseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(26.0),
                      child: Text(
                        widget.info.name.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26.0, vertical: 10),
                    child: DelayedDisplay(
                      delay: const Duration(microseconds: 700),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(-2, -2),
                              blurRadius: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                            ),
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.10),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text("${widget.info.cookTime} Min",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(
                                    "Ready in",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.info.category != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 26.0, left: 26.0, right: 26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Html(
                            data: widget.info.category,
                            style: {
                              'p': Style(
                                fontSize: FontSize.large,
                                color: Colors.black,
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  if (widget.info.ingredients != null)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ingredients",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Html(
                            data: widget.info.ingredients,
                            style: {
                              'p': Style(
                                fontSize: FontSize.large,
                                color: Colors.black,
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  // ignore: unnecessary_null_comparison
                  if (widget.info.instructions != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 26.0, bottom: 26.0, right: 26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Instructions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Html(
                            data: widget.info.instructions,
                            style: {
                              'p': Style(
                                fontSize: FontSize.large,
                                color: Colors.black,
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(left: 26.0, right: 26.0),
                    child: Text("Recommendations",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 26.0, right: 26.0),
                    child: SizedBox(
                        height: 280,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: listSimilarity.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RecipeDetail(
                                          info: listSimilarity[index],
                                        )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(-2, -2),
                                        blurRadius: 12,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                      ),
                                      BoxShadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 5,
                                        color: Color.fromRGBO(0, 0, 0, 0.10),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Container(
                                          foregroundDecoration:
                                              const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                          width: double.infinity,
                                          child: Image.asset(
                                            'assets/bg.jpg',
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 150,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(9),
                                        child: Text(
                                          listSimilarity[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Text(
                                          "Ready in ${listSimilarity[index].cookTime} Min",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  )
                ]),
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../animation/animation.dart';
import '../../../models/equipment.dart';
import '../../../models/similar_result.dart';
import '../../../models/recipe.dart';

import 'appBar.dart';
import 'equipments.dart';
import 'similar_recipe.dart';
import 'ingredients.dart';

class RecipeDataWidget extends StatefulWidget {
  final Recipe info;
  final List<Similar> similarlist;
  final List<Equipment> equipment;

  const RecipeDataWidget({
    Key? key,
    required this.info,
    required this.similarlist,
    required this.equipment,
  }) : super(key: key);

  @override
  State<RecipeDataWidget> createState() => _RecipeDataWidgetState();
}

class _RecipeDataWidgetState extends State<RecipeDataWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 300, info: widget.info),
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
                        widget.info.title!,
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
                                  Text("${widget.info.readyInMinutes} Min",
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
                  const Padding(
                    padding: EdgeInsets.all(26.0),
                    child: DelayedDisplay(
                      delay: const Duration(microseconds: 700),
                      child: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  if (widget.info.extendedIngredients!.isNotEmpty)
                    DelayedDisplay(
                      delay: const Duration(microseconds: 600),
                      child: IngredientsWidget(
                        recipe: widget.info,
                      ),
                    ),
                  if (widget.info.instructions != null)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
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
                  if (widget.equipment.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(26.0),
                      child: Text(
                        "Equipments",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  if (widget.equipment.isNotEmpty)
                    EquipmentsListView(
                      equipments: widget.equipment,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.similarlist.isNotEmpty)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 26),
                      child: Text("Similar items",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  if (widget.similarlist.isNotEmpty)
                    SimilarListWidget(items: widget.similarlist),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
          )
        ],
      ),
    );
  }
}

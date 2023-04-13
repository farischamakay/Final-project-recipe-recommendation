import 'package:flutter/material.dart';

import '../../../models/food_type.dart';

class RecommendationListWidget extends StatelessWidget {
  final List<FoodType> items;
  const RecommendationListWidget({Key? key, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 280,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          // store this controller in a State to save the carousel scroll position
          children: [
            const SizedBox(width: 20),
            ...items.map((item) {
              return Container();
              // return RecipeCardType(items: item);
            }).toList()
          ],
        ));
  }
}

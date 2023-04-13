import 'package:cooking_tutorial_application/models/recipe_recommendation.dart';
import 'package:cooking_tutorial_application/screens/recipe_view/recipeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/food_type.dart';
import '../../models/recipe.dart';
import '../home/widget/list_items.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff1bb274),
          title: const Text(
            "EasyCook",
            style: TextStyle(
                fontFamily: 'Satisfy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('Favorite').listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        CupertinoIcons.heart_fill,
                        size: 105,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "There is no favorite recipe.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemBuilder: (context, i) {
                    final info = box.getAt(i);
                    final data = Recipe.fromJson(info);
                    // final data1 = RecipeRecom.fromJson(info);

                    return ListItem(
                      meal: FoodType(
                        id: data.id.toString(),
                        image: data.image!,
                        name: data.title!,
                        readyInMinutes: data.readyInMinutes.toString(),
                      ),
                    );

                    // return Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 10.0, left: 16.0, right: 16.0),
                    //     child: GestureDetector(
                    //       child: Container(
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(8),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               spreadRadius: 5,
                    //               blurRadius: 7,
                    //               offset: Offset(0, 3),
                    //             ),
                    //           ], // sets the rounded corners of the container
                    //         ),
                    //         child: Center(
                    //           child: ListTile(
                    //             leading: ClipRRect(
                    //               borderRadius: BorderRadius.circular(8),
                    //               child: Image.asset('assets/bg.jpg'),
                    //             ),
                    //             title: Text(
                    //               data1.name.toString().toUpperCase(),
                    //               style: const TextStyle(color: Colors.red),
                    //             ),
                    //             subtitle:
                    //                 Text("Ready in ${data1.cookTime} Minutes"),
                    //           ),
                    //         ),
                    //       ),
                    //       onTap: () => Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   RecipeDetail(info: data1))),
                    //     ));
                  },
                  itemCount: box.length);
            }),
      ),
    );
  }
}

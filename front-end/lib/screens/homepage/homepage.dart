import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_tutorial_application/models/recipe_recommendation.dart';
import 'package:cooking_tutorial_application/responses/recipe_recom_data.dart';
import 'package:cooking_tutorial_application/screens/homepage/list_popular.dart';
import 'package:cooking_tutorial_application/screens/homepage/list_recommendation.dart';
import 'package:cooking_tutorial_application/screens/recipe_view/recipeView.dart';
import 'package:cooking_tutorial_application/screens/start/ingredients/input_ingredients.dart';
import 'package:cooking_tutorial_application/screens/start/screens/edit_preferences.dart';
import 'package:cooking_tutorial_application/screens/start/screens/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../animation/animation.dart';

class Homepage extends StatefulWidget {
  static const nameRoute = '/homepage';
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool _isLoading;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  List<RecipeRecom> listRecom = [];
  List<RecipeRecom> listPopular = [];
  List<RecipeRecom> listByIngredientsRecom = [];
  RecipeDataRecomResponse recipeResponse = RecipeDataRecomResponse();

  getPopularRecipe() async {
    listPopular = await recipeResponse.getPopularRecipe();
    setState(() {});
  }

  getRecomRecipe() async {
    try {
      listRecom = await recipeResponse.getRecomRecipe();
      setState(() {});
    } catch (e) {
      print('Error fetching recipe data: $e');
      setState(() {});
    }
  }

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
    getPopularRecipe();
    getRecomRecipe();
    getRecomByIngredientsRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DocumentReference myDocument = FirebaseFirestore.instance
        .collection('recommendations')
        .doc('third_recommendation');
    final docSnapshot = FirebaseFirestore.instance
        .collection('recommendations')
        .doc('third_recommendation')
        .get();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong!");
              }
              if (snapshot != null && snapshot.data != null) {
                return DelayedDisplay(
                    delay: Duration(microseconds: 800),
                    child: Text(
                      "Hi, ${snapshot.data!.get('username')} \nHappy Cooking!",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ));
              }
              return Container();
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    header("Popular"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ListMorePopular()));
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.grey),
                        ))
                  ],
                ),
              ],
            )),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  height: 270,
                  width: 370,
                  child: ListView.separated(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, indext) {
                        return GestureDetector(
                            child: Container(
                                padding: EdgeInsets.all(20),
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
                                      listPopular[indext].name.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.redAccent),
                                    ),
                                    Text(
                                      "Ready in ${listPopular[indext].cookTime} Minutes",
                                      // style:
                                      //     const TextStyle(color: Colors.redAccent),
                                    ),
                                    Text(
                                      "By ${listPopular[indext].author}",
                                      // style:
                                      //     const TextStyle(color: Colors.redAccent),
                                    ),
                                  ],
                                )),
                            onTap: () async {
                              if (listPopular != null) {
                                myDocument.update(
                                    {'title': listPopular[indext].name});
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipeDetail(
                                            info: listPopular[indext])));
                              }
                            });
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 7,
                        );
                      },
                      itemCount: listPopular.length),
                ),
              ),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                header("Your Recommendation"),
              ],
            )),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : listRecom.isEmpty
                ? const SizedBox(
                    height: 230,
                    width: 370,
                    child: Center(
                      child: Text(
                        "No recommendations",
                        style: TextStyle(color: Colors.red),
                      ),
                    ))
                : SizedBox(
                    height: 230,
                    width: 370,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListView(
                        padding: const EdgeInsets.all(5),
                        children: List.generate(
                            listRecom.length,
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
                                      listRecom[index].name.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.redAccent),
                                    ),
                                    subtitle: Text(
                                        "Ready in ${listRecom[index].cookTime} Minutes"),
                                  ),
                                ),
                                onTap: () async {
                                  if (listPopular != null) {
                                    myDocument.update(
                                        {'title': listRecom[index].name});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RecipeDetail(
                                                info: listRecom[index])));
                                  }
                                })),
                      ),
                    )),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                header("What's on your fridge?"),
              ],
            )),
        SizedBox(
            height: 180,
            width: 370,
            child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InputIngredientsPage()));
                    },
                    child: const Text(
                      "Input",
                      style: TextStyle(fontSize: 18),
                    ))))
      ]),
    ));
  }

  header(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: Text(name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
    );
  }
}

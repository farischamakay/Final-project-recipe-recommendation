// import 'package:cooking_tutorial_application/screens/home/widget/recommendation_list.dart';
// import 'package:cooking_tutorial_application/screens/recipe_search_result/bloc/recipe_search_result_bloc.dart';
// import 'package:flutter/material.dart';
// import '../recipe_search_result/recipe_search_result.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../animation/animation.dart';
// import '../../models/food_type.dart';
// import '../home/bloc/homepage_recipe_bloc.dart';
// import '../home/widget/food_category_list.dart';
// import '../home/widget/horizontal_list.dart';
// import '../home/widget/list_items.dart';

// class Homepage extends StatefulWidget {
//   static const nameRoute = '/homepage';
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   late final HomeRecipesBloc bloc;
//   @override
//   void initState() {
//     bloc = BlocProvider.of<HomeRecipesBloc>(context);
//     bloc.add(LoadHomepageRecipe());

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery(
//       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: const Color(0xfff1bb274),
//           title: Text(
//             "EasyCook",
//             style: Theme.of(context).textTheme.headline1,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         body: BlocBuilder<HomeRecipesBloc, HomepageRecipeState>(
//           builder: (context, state) {
//             if (state is HomepageRecipeLoading) {
//               return const Center(child: LoadingWidget());
//             } else if (state is HomepageRecipeSuccess) {
//               return HomeScreenWidget(
//                 breakfast: state.breakfast,
//                 cake: state.cake,
//                 drinks: state.drinks,
//                 burgers: state.burgers,
//                 lunch: state.lunch,
//                 pizza: state.pizza,
//                 rice: state.rice,
//               );
//             } else if (state is HomepageRecipeError) {
//               return Center(
//                 child: Container(
//                   child: const Text("Error"),
//                 ),
//               );
//             } else {
//               return Center(
//                 child: Container(
//                   child: const Text("Waiting..."),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomeScreenWidget extends StatefulWidget {
//   final List<FoodType> breakfast;
//   final List<FoodType> lunch;
//   final List<FoodType> drinks;
//   final List<FoodType> burgers;
//   final List<FoodType> pizza;
//   final List<FoodType> cake;
//   final List<FoodType> rice;

//   const HomeScreenWidget({
//     super.key,
//     required this.breakfast,
//     required this.lunch,
//     required this.drinks,
//     required this.burgers,
//     required this.pizza,
//     required this.cake,
//     required this.rice,
//   });

//   @override
//   _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
// }

// class _HomeScreenWidgetState extends State<HomeScreenWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: DelayedDisplay(
//               delay: Duration(microseconds: 600),
//               child: Text(
//                 "Hello, \nHappy Cooking!",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 26,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const HorizontalList(),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 26.0),
//             child: header("Recipes Recomendation", ""),
//           ),
//           const SizedBox(height: 10),
//           DelayedDisplay(
//             delay: const Duration(microseconds: 600),
//             // child: FoodTypeWidget(
//             //   items: widget.breakfast,
//             // ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 26.0),
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 child: Center(
//                   child: Text(
//                       'No Recommendation. \nPlease add your preference in profile'),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 26.0),
//             child: header("Breakfast Popular Recipes", ""),
//           ),
//           const SizedBox(height: 10),
//           DelayedDisplay(
//             delay: const Duration(microseconds: 600),
//             child: FoodTypeWidget(
//               items: widget.breakfast,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 26.0),
//             child: header("Breakfast Recipes Ideas", "breakfast"),
//           ),
//           const SizedBox(height: 10),
//           DelayedDisplay(
//             delay: const Duration(microseconds: 600),
//             child: FoodTypeWidget(
//               items: widget.lunch,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 header("Lunch Recipes Ideas", "lunch"),
//                 ...widget.lunch.map((meal) {
//                   return ListItem(
//                     meal: meal,
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 26.0),
//             child: header("Drinks Recipes", "drinks"),
//           ),
//           const SizedBox(height: 10),
//           FoodTypeWidget(items: widget.drinks),
//           // Padding(
//           //   padding: const EdgeInsets.all(14.0),
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       header("Best burgers Recipes", "burgers"),
//           //       ...widget.burgers.map((meal) {
//           //         return ListItem(
//           //           meal: meal,
//           //         );
//           //       }).toList(),
//           //     ],
//           //   ),
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 26.0),
//           //   child: header("pizza", "pizza"),
//           // ),
//           // const SizedBox(height: 10),
//           // FoodTypeWidget(items: widget.pizza),
//           // Padding(
//           //   padding: const EdgeInsets.all(14.0),
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       header("Wants best cake", "cake"),
//           //       ...widget.cake.map((meal) {
//           //         return ListItem(
//           //           meal: meal,
//           //         );
//           //       }).toList(),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   header(String name, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           DelayedDisplay(
//             delay: const Duration(microseconds: 600),
//             child: Text(name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 )),
//           ),
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider(
//                       create: (context) => RecipeSearchResultBloc(),
//                       child: SearchResults(
//                         id: title,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               icon: Icon(Icons.arrow_forward_sharp))
//         ],
//       ),
//     );
//   }
// }

// class LoadingWidget extends StatelessWidget {
//   const LoadingWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 30,
//       height: 30,
//       child: CircularProgressIndicator(
//         color: Colors.redAccent,
//         strokeWidth: 1.5,
//         backgroundColor: Colors.grey,
//       ),
//     );
//   }
// }

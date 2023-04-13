// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import '../../../models/failure.dart';
// import '../../../models/food_type.dart';
// import '../../../responses/recipe_homepage.dart';

// part 'homepage_recipe_event.dart';
// part 'homepage_recipe_state.dart';

// class HomeRecipesBloc extends Bloc<HomepageRecipeEvent, HomepageRecipeState> {
//   final repo = GetHomeRecipes();
//   HomeRecipesBloc(LoadHomepageRecipe loadHomepageRecipe)
//       : super(HomepageRecipeInitial()) {
//     on<HomepageRecipeEvent>((event, emit) async {
//       if (event is LoadHomepageRecipe) {
//         try {
//           emit(HomepageRecipeLoading());
//           final data = await Future.wait([
//             repo.getRecipes('breakfast', 20),
//             repo.getRecipes('lunch', 3),
//             repo.getRecipes('drinks', 20),
//             repo.getRecipes('pizza', 3),
//             repo.getRecipes('burgers', 20),
//             repo.getRecipes('cake', 20),
//             repo.getRecipes('rice', 20),
//           ]);
//           emit(
//             HomepageRecipeSuccess(
//               breakfast: data[0].list,
//               lunch: data[1].list,
//               drinks: data[2].list,
//               burgers: data[4].list,
//               pizza: data[3].list,
//               cake: data[5].list,
//               rice: data[6].list,
//             ),
//           );
//         } on Failure catch (e) {
//           emit(HomepageFailureState(error: e));
//         } catch (e) {
//           print(e.toString());
//           emit(HomepageRecipeError());
//         }
//       }
//     });
//   }
// }

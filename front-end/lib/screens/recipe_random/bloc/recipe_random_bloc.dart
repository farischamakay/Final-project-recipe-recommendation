import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../responses/recipe_random.dart';
import 'package:meta/meta.dart';
import '../../../models/recipe.dart';
import '../../../models/equipment.dart';
import '../../../models/similar_result.dart';
import '../../../models/failure.dart';

part 'recipe_random_event.dart';
part 'recipe_random_state.dart';

class RecipeRandomBloc extends Bloc<RecipeRandomEvent, RecipeRandomState> {
  final GetRandomRecipe viewmodels = GetRandomRecipe();

  RecipeRandomBloc() : super(RecipeRandomInitial()) {
    on<RecipeRandomEvent>((event, emit) async {
      if (event is LoadRandomRecipe) {
        try {
          emit(RecipeRandomLoadState());
          final data = await viewmodels.getRecipe();
          emit(
            RecipeRandomSuccesState(
              recipe: data[0],
              similar: data[1].list,
              equipment: data[2].items,
            ),
          );
        } on Failure catch (e) {
          emit(FailureState(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeRandomErrorState());
        }
      }
    });
  }
}

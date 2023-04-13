import 'package:bloc/bloc.dart';
import 'package:cooking_tutorial_application/models/recipe.dart';
import 'package:flutter/foundation.dart';
import '../../../responses/recipe_data.dart';
import '../../../models/similar_result.dart';
import '../../../models/equipment.dart';
import '../../../models/failure.dart';

part 'recipe_data_event.dart';
part 'recipe_data_state.dart';

class RecipeDataBloc extends Bloc<RecipeDataEvent, RecipeDataState> {
  final GetRecipeData repo = GetRecipeData();

  RecipeDataBloc() : super(RecipeDataInitial()) {
    on<RecipeDataEvent>((event, emit) async {
      if (event is LoadRecipeData) {
        try {
          emit(RecipeDataLoadState());
          final data = await repo.getRecipeData(event.id);
          emit(
            RecipeDataSuccesState(
              recipe: data[0],
              similar: data[1].list,
              equipment: data[2].items,
            ),
          );
        } on Failure catch (e) {
          emit(FailureState(error: e));
        } catch (e) {
          print(e.toString());
          emit(RecipeDataErrorState());
        }
      }
    });
  }
}

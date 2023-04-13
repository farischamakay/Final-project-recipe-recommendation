part of 'recipe_data_bloc.dart';

@immutable
abstract class RecipeDataEvent {}

class LoadRecipeData extends RecipeDataEvent {
  final String id;

  LoadRecipeData(this.id);
}

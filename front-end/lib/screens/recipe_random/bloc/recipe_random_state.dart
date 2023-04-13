part of 'recipe_random_bloc.dart';

@immutable
abstract class RecipeRandomState {}

class RecipeRandomInitial extends RecipeRandomState {}

class RecipeRandomLoadState extends RecipeRandomState {}

class RecipeRandomSuccesState extends RecipeRandomState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipment> equipment;
  // final Nutrient nutrient;

  RecipeRandomSuccesState({
    required this.recipe,
    required this.similar,
    // required this.nutrient,
    required this.equipment,
  });
}

class RecipeRandomErrorState extends RecipeRandomState {}

class FailureState extends RecipeRandomState {
  final Failure error;

  FailureState({required this.error});
}

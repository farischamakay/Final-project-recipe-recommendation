part of 'recipe_search_result_bloc.dart';

abstract class RecipeSearchResultEvent extends Equatable {
  const RecipeSearchResultEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchResults extends RecipeSearchResultEvent {
  final String name;
  const LoadSearchResults({
    required this.name,
  });
}

part of 'recipe_search_result_bloc.dart';

abstract class RecipeSearchResultState extends Equatable {
  const RecipeSearchResultState();

  @override
  List<Object> get props => [];
}

class SearchResultsInitial extends RecipeSearchResultState {}

class SearchResultsLoading extends RecipeSearchResultState {}

class SearchResultsSuccess extends RecipeSearchResultState {
  final List<SearchResult> results;
  SearchResultsSuccess({
    required this.results,
  });
}

class SearchResultsError extends RecipeSearchResultState {}

class HomeFailureState extends RecipeSearchResultState {
  final Failure error;

  const HomeFailureState({required this.error});
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/failure.dart';
import '../../../models/search_result.dart';
import '../../../responses/get_recipe_result.dart';

part 'recipe_search_result_event.dart';
part 'recipe_search_result_state.dart';

class RecipeSearchResultBloc
    extends Bloc<RecipeSearchResultEvent, RecipeSearchResultState> {
  final repo = SearchRepo();
  RecipeSearchResultBloc() : super(SearchResultsInitial()) {
    on<RecipeSearchResultEvent>((event, emit) async {
      if (event is LoadSearchResults) {
        try {
          emit(SearchResultsLoading());
          final results = await repo.getSearchList(event.name, 100);
          emit(SearchResultsSuccess(
            results: results.list,
          ));
        } on Failure catch (e) {
          emit(HomeFailureState(error: e));
        } catch (e) {
          print(e.toString());
          emit(SearchResultsError());
        }
      }
    });
  }
}

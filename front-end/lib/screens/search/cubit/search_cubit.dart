import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/auto_complete.dart';
import '../../../responses/get_recipe_result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());
  final repo = SearchRepo();
  void textChange(String text) async {
    emit(state.copyWith(status: Status.loading, searchText: text));
    final list = await repo.getAutoCompleteList(text);
    emit(state.copyWith(status: Status.success, searchList: list.list));
  }
}

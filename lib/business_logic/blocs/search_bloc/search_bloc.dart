import 'package:crm/data/repositories/mock_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchController searchController = SearchController();
  final TextEditingController textEditingController = TextEditingController();


  SearchBloc() : super(SearchInitial()) {
    on<SearchValueChanged>(searchQueryChanged);
    init();
  }
  init(){
    searchController.addListener(() {
      add(SearchValueChanged(searchController.text));
    });
  }

  searchQueryChanged(SearchValueChanged event, Emitter emit) {
    emit(SearchQueryLoading());
    try {
      final data = MockData.filter(event.query);
      emit(SearchQuerySuccess(data));
    } catch (e) {
      emit(SearchQueryError(e.toString()));
    }
  }
}

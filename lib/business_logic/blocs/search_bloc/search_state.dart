part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchQueryLoading extends SearchState {}

class SearchQuerySuccess extends SearchState {
  final List<ClientModel> data;

  SearchQuerySuccess(this.data);
}

class SearchQueryError extends SearchState {
  final String error;

  SearchQueryError(this.error);
}

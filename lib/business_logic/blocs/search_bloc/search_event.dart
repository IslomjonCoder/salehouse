part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchValueChanged extends SearchEvent {
  final String query;

  SearchValueChanged(this.query);
}

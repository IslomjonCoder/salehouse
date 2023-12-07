part of 'homes_bloc.dart';

abstract class HomesEvent {}

class HomesEventInitial extends HomesEvent {}

// class NextPageEvent extends HomesEvent {
//   int page;
//
//   NextPageEvent(this.page);
// }
class SelectBlocEvent extends HomesEvent {
  int blocIndex;

  SelectBlocEvent(this.blocIndex);
}
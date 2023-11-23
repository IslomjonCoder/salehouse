part of 'free_homes_bloc.dart';

abstract class FreeHomesEvent {}

class GetFreeHomesEvent extends FreeHomesEvent {}

class GetFreeHomesByBlockIdEvent extends FreeHomesEvent {
  final int blockId;

  GetFreeHomesByBlockIdEvent({required this.blockId});
}

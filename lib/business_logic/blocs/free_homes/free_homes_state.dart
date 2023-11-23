part of 'free_homes_bloc.dart';

class FreeHomesState {
  final Status status;
  final String error;
  final List<FreeHomeModel> data;
  final int? blockId;

  FreeHomesState({
    this.status = Status.initial,
    this.error = '',
    this.data = const [],
    this.blockId,
  });

  FreeHomesState copyWith({
    Status? status,
    String? error,
    List<FreeHomeModel>? data,
    int? blockId,
  }) {
    return FreeHomesState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
      blockId: blockId ?? this.blockId,
    );
  }
}

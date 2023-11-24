part of 'objects_bloc.dart';

class ObjectsState {
  final Status status;
  final List<ObjectModel> objects;
  String error;

  ObjectsState({
    this.status = Status.initial,
    this.objects = const [],
    this.error = '',
  });

  ObjectsState copyWith({
    Status? status,
    List<ObjectModel>? objects,
    String? error,
  }) {
    return ObjectsState(
      status: status ?? this.status,
      objects: objects ?? this.objects,
      error: error ?? this.error,
    );
  }
}

part of 'general_bloc.dart';

class GeneralState {
  List<BlockModel> blocs;
  Status status;
  String? error;

  GeneralState({
    this.blocs = const [],
    this.status = Status.initial,
    this.error,
  });

  GeneralState copyWith({
    List<BlockModel>? blocs,
    Status? status,
    final String? error,

  }) {
    return GeneralState(
      blocs: blocs ?? this.blocs,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

part of 'regions_bloc.dart';

class RegionsState {
  final Status status;
  final List<RegionModel> regions;
  String error;

  RegionsState({
    this.status = Status.initial,
    this.regions = const [],
    this.error = '',
  });

  RegionsState copyWith({
    Status? status,
    List<RegionModel>? regions,
    String? error,
  }) {
    return RegionsState(
      status: status ?? this.status,
      regions: regions ?? this.regions,
      error: error ?? this.error,
    );
  }
}

part of 'general_bloc.dart';

class GeneralState {
  List<RegionModel> regions;
  List<CompanyModel> companies;
  List<ObjectModel> objects;
  List<BlockModel> blocs;
  Status status;
  String? error;

  GeneralState({
    this.regions = const [],
    this.companies = const [],
    this.objects = const [],
    this.blocs = const [],
    this.status = Status.initial,
    this.error,
  });

  GeneralState copyWith({
    List<RegionModel>? regions,
    List<CompanyModel>? companies,
    List<ObjectModel>? objects,
    List<BlockModel>? blocs,
    Status? status,
    final String? error,

  }) {
    return GeneralState(
      regions: regions ?? this.regions,
      companies: companies ?? this.companies,
      objects: objects ?? this.objects,
      blocs: blocs ?? this.blocs,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

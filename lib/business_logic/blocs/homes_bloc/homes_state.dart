part of 'homes_bloc.dart';


class HomesState {
  Status status;
  // HomeModel? contractModel;
  List<HomeModelUser> contracts;
  // int currentPage;
  // bool nextPageLoading;
  String error;
  int blocIndex;

  HomesState({
    this.status = Status.initial,
    this.contracts = const [],
    // this.contractModel,
    // this.currentPage = 1,
    // this.nextPageLoading = false,
    this.error = '',
    this.blocIndex = 1,
  });

  HomesState copyWith({
    Status? status,
    HomeModel? contractModel,
    List<HomeModelUser>? contracts,
    int? currentPage,
    bool? nextPageLoading,
    String? error,
    int? blocIndex,

  }) {
    return HomesState(
      status: status ?? this.status,
      // contractModel: contractModel ?? this.contractModel,
      contracts: contracts ?? this.contracts,
      // currentPage: currentPage ?? this.currentPage,
      // nextPageLoading: nextPageLoading ?? this.nextPageLoading,
      error: error ?? this.error,
      blocIndex: blocIndex ?? this.blocIndex,
    );
  }
}

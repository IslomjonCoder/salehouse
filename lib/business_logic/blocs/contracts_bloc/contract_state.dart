part of 'contract_bloc.dart';

class ContractState {
  Status status;
  ContractModel? contractModel;
  List<ContractUser> contracts;
  int currentPage;
  bool nextPageLoading;
  String error;

  ContractState({
    this.status = Status.initial,
    this.contracts = const [],
    this.contractModel,
    this.currentPage = 1,
    this.nextPageLoading= false,
    this.error = '',
  });

  ContractState copyWith({
    Status? status,
    ContractModel? contractModel,
    List<ContractUser>? data,
    int? currentPage,
    bool? nextPageLoading,
    String? error,

  }) {
    return ContractState(
      status: status ?? this.status,
      contractModel: contractModel ?? this.contractModel,
      contracts: data ?? contracts,
      currentPage: currentPage ?? this.currentPage,
      nextPageLoading: nextPageLoading ?? this.nextPageLoading,
      error: error ?? this.error,
    );
  }
}

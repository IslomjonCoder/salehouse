part of 'contract_bloc.dart';

class ContractState {
  Status status;
  ContractModel? contractModel;
  List<ContractUser> contracts;
  int currentPage;
  String error;

  ContractState({
    this.status = Status.initial,
    this.contracts = const [],
    this.contractModel,
    this.currentPage = 1,
    this.error = '',
  });

  ContractState copyWith({
    Status? status,
    ContractModel? contractModel,
    List<ContractUser>? data,
    int? currentPage,
    String? error,

  }) {
    return ContractState(
      status: status ?? this.status,
      contractModel: contractModel ?? this.contractModel,
      contracts: data ?? this.contracts,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }
}

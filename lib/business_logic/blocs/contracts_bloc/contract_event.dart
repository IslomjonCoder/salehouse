part of 'contract_bloc.dart';

abstract class ContractEvent {}

class ContractEventInitial extends ContractEvent {}

class SearchContractsEvent extends ContractEvent {
  final String query;

  SearchContractsEvent({required this.query});
}

//
// class NextPageEvent extends ContractEvent {
//   int page;
//
//   NextPageEvent(this.page);
// }

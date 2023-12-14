// contract_bloc.dart

import 'package:crm/data/models/contract_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();

  ContractBloc() : super(ContractState()) {
    on<ContractEventInitial>(_onContractEventInitial);
    on<SearchContractsEvent>(_onSearchContractsEvent);
  }

  _onSearchContractsEvent(SearchContractsEvent event, Emitter<ContractState> emit) async {
    try {
      final searchResults = _searchContracts(event.query);
      emit(
        state.copyWith(
          data: searchResults,
          status: Status.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        error: e.toString(),
      ));
    }
  }

  List<ContractUser> _searchContracts(String query) {
    // Implement your search logic here based on the query
    // You may filter the contracts list by name or surname
    return state.contracts
        .where((contract) =>
            contract.custom.name.toLowerCase().contains(query.toLowerCase()) ||
            contract.custom.surname.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  _onContractEventInitial(ContractEventInitial event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.contracts();
      emit(
        state.copyWith(
          data: contract,
          status: Status.success,
          // currentPage: 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

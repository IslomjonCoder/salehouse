// contract_bloc.dart

import 'package:crm/data/models/contract_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/cache/cache_manager.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();
  CacheManager cacheManager = CacheManager();

  ContractBloc() : super(ContractState()) {
    on<ContractEventInitial>(_onContractEventInitial);
    on<SearchContractsEvent>(_onSearchContractsEvent);
  }

  _onSearchContractsEvent(SearchContractsEvent event, Emitter<ContractState> emit) async {
    final List<ContractUser>? contracts = cacheManager.get('contracts');
    if (contracts != null) {
      final searchResults = contracts
          .where((element) =>
              element.custom.fullName.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(data: searchResults, status: Status.success));
      return;
    }
    try {
      final searchResults = _searchContracts(event.query);
      emit(state.copyWith(data: searchResults, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  List<ContractUser> _searchContracts(String query) {
    return state.contracts
        .where((contract) =>
            contract.custom.name.toLowerCase().contains(query.toLowerCase()) ||
            contract.custom.surname.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  _onContractEventInitial(ContractEventInitial event, Emitter<ContractState> emit) async {
    final contracts = cacheManager.get('contracts');
    if (contracts != null) {
      emit(state.copyWith(data: contracts, status: Status.success));
      return;
    }

    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.contracts();
      cacheManager.add('contracts', contract);
      emit(state.copyWith(data: contract, status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

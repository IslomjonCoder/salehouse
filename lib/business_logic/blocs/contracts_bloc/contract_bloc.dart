import 'package:crm/data/models/contract_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();

  ContractBloc() : super(ContractState()) {
    on<ContractEventInitial>(_onContractEventInitial);
    on<NextPageEvent>(_onNextPageEvent, transformer: droppable(
    ),);
    initialize();
  }

  initialize() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (state.contractModel != null) {
          if (state.currentPage < state.contractModel!.lastPage) {
            add(NextPageEvent(state.currentPage + 1));
          }
        }
      }
    });
  }

  _onNextPageEvent(NextPageEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(nextPageLoading: true));
    try {
      final contract = await apiService.getContractByPage(event.page);
      final contracts = contract.data;
      emit(state.copyWith(
          contractModel: contract,
          status: Status.success,
          data: state.contracts..addAll(contracts),
          currentPage: event.page,
          nextPageLoading: false
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString(),nextPageLoading: false));
    }
  }

  _onContractEventInitial(ContractEventInitial event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.getContractByPage(1);
      emit(state.copyWith(
          contractModel: contract, status: Status.success, data: contract.data, currentPage: 1));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

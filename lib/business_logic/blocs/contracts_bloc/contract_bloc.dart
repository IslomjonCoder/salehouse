
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/data/models/contract_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/logging/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();

  ContractBloc() : super(ContractState()) {
    on<ContractEventInitial>(_onContractEventInitial);
    on<NextPageEvent>(_onNextPageEvent);
    initialize();
  }



  initialize()async{
    scrollController.addListener(() {
      print("Current position max");
      print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(state.contractModel != null){
          if(state.currentPage < state.contractModel!.lastPage){
            add(ContractEventInitial());
          }
        }
      }
    });
  }
  _onNextPageEvent(NextPageEvent event, Emitter<ContractState> emit) async {
TLoggerHelper.debug('page: ${event.page}');
    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.getContractByPage( event.page);
      emit(state.copyWith(
          contractModel: contract, status: Status.success, data: contract.data, currentPage: event.page));
    } catch (e) {
      if (e is DioException) {
        final message = handlerError(e);
        emit(state.copyWith(status: Status.failure, error: message));
        return;
      }
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  _onContractEventInitial(ContractEventInitial event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.contracts();
      emit(state.copyWith(
          contractModel: contract, status: Status.success, data: contract.data, currentPage: 1));
    } catch (e) {
      if (e is DioException) {
        final message = handlerError(e);
        emit(state.copyWith(status: Status.failure, error: message));
        return;
      }
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}


import 'package:crm/data/models/home_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/cache/cache_manager.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'homes_event.dart';

part 'homes_state.dart';

class HomesBloc extends Bloc<HomesEvent, HomesState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();
  CacheManager cacheManager = CacheManager();

  HomesBloc() : super(HomesState()) {
    on<HomesEventInitial>(_onHomesEventInitial);
    // on<NextPageEvent>(_onNextPageEvent);
    on<SelectBlocEvent>(_onSelectBlocEvent);
    // initialize();
  }

  // initialize() async {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //       if (state.contractModel != null) {
  //         if (state.currentPage < state.contractModel!.lastPage) {
  //           add(NextPageEvent(state.currentPage + 1));
  //         }
  //       }
  //     }
  //   });
  // }

  _onSelectBlocEvent(SelectBlocEvent event, Emitter<HomesState> emit) async {
    dynamic cachedData = cacheManager.get('homesData${event.blocIndex}');
    if (cachedData != null) {
      emit(state.copyWith(status: Status.success, contracts: cachedData, blocIndex: event.blocIndex));
      return;
    }
    emit(state.copyWith(blocIndex: event.blocIndex, status: Status.loading));
    // Try to get data from the cache first

    try {
      final contract = await apiService.home( bloc: event.blocIndex);
      cacheManager.add('homesData${event.blocIndex}', contract);
      emit(state.copyWith(
        status: Status.success,
        // contractModel: contract,
        contracts: contract,
        currentPage: 1,
        blocIndex: event.blocIndex,
      ),);
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  _onHomesEventInitial(HomesEventInitial event, Emitter<HomesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final contract = await apiService.home( bloc: state.blocIndex);
      emit(state.copyWith(
          status: Status.success,
          // contractModel: contract,
          contracts: contract,
          currentPage: 1,),);
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  // _onNextPageEvent(NextPageEvent event, Emitter<HomesState> emit) async {
  //   emit(state.copyWith(nextPageLoading: true));
  //   try {
  //     final contract = await apiService.home( bloc: state.blocIndex);
  //
  //     // final contracts = contract.data;
  //
  //     emit(state.copyWith(
  //       // contractModel: contract,
  //       status: Status.success,
  //       contracts: contract,
  //       nextPageLoading: false,
  //       currentPage: event.page,
  //     ),);
  //   } catch (e) {
  //     emit(state.copyWith(status: Status.failure, error: e.toString(), nextPageLoading: false));
  //   }
  // }
}

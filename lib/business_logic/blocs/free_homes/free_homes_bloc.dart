
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/data/models/free_home_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/cache/cache_manager.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/logging/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'free_homes_event.dart';

part 'free_homes_state.dart';

class FreeHomesBloc extends Bloc<FreeHomesEvent, FreeHomesState> {
  ApiService apiService = ApiService();
  CacheManager cacheManager = CacheManager();

  FreeHomesBloc() : super(FreeHomesState()) {
    on<GetFreeHomesEvent>(_onGetFreeHomesEvent);
    on<GetFreeHomesByBlockIdEvent>(_onGetFreeHomesByBlockIdEvent);
  }

  _onGetFreeHomesEvent(GetFreeHomesEvent event, Emitter<FreeHomesState> emit) async {
    emit(state.copyWith(status: Status.loading));

    // Try to get data from the cache first
    dynamic cachedData = cacheManager.get('freeHomesData');
    if (cachedData != null) {
      emit(state.copyWith(status: Status.success, data: cachedData));
      return;
    }

    try {
      final response = await apiService.freeHome(1);
      cacheManager.add('freeHomesData', response); // Cache the data
      emit(state.copyWith(status: Status.success, data: response));
    } catch (e) {
      if (e is DioException) {
        TLoggerHelper.info("Dio Error");
        print(e.type);
        final message = handlerError(e);
        emit(state.copyWith(status: Status.failure, error: message));
        return;
      }
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  _onGetFreeHomesByBlockIdEvent(
      GetFreeHomesByBlockIdEvent event, Emitter<FreeHomesState> emit) async {
    emit(state.copyWith(status: Status.loading));

    // Use the blockId as part of the cache key
    String cacheKey = 'freeHomesData_blockId_${event.blockId}';
    dynamic cachedData = cacheManager.get(cacheKey);
    if (cachedData != null) {
      emit(state.copyWith(status: Status.success, data: cachedData));
      return;
    }

    try {
      final response = await apiService.freeHome(event.blockId);
      cacheManager.add(cacheKey, response); // Cache the data
      emit(state.copyWith(status: Status.success, data: response));
    } catch (e) {
      if (e is DioException) {
        TLoggerHelper.info("Dio Error");
        print(e.type);
        final message = handlerError(e);
        emit(state.copyWith(status: Status.failure, error: message,blockId: event.blockId));
        return;
      }
      emit(state.copyWith(status: Status.failure, error: e.toString(),blockId: event.blockId));
    }
  }
}

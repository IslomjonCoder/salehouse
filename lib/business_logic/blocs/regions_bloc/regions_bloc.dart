import 'dart:async';
import 'dart:convert';

import 'package:crm/data/models/object_model.dart';
import 'package:crm/data/models/region_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:crm/utils/logging/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'regions_event.dart';

part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  ApiService apiService = ApiService();

  RegionsBloc() : super(RegionsState()) {
    on<RegionsInitialEvent>(_onRegionsInitialEvent);
  }

  _onRegionsInitialEvent(RegionsInitialEvent event, Emitter<RegionsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final regions = await TLocalStorage.getString(TLocalStorageKeys.regions);
      if (regions != null) {
        emit(state.copyWith(
            status: Status.success,
            regions: List.from(jsonDecode(regions)).map((e) => RegionModel.fromJson(e)).toList()));

        return;
      }

      final response = await apiService.regions();
      TLocalStorage.saveString(TLocalStorageKeys.regions,
          response.map((e) => jsonEncode(e.toJson())).toList().toString());
      TLoggerHelper.info(response.toString());
      emit(state.copyWith(status: Status.success, regions: response));
    } catch (e) {
      TLoggerHelper.error(e.toString());
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

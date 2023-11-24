import 'package:crm/data/models/block_model.dart';
import 'package:crm/data/models/company_model.dart';
import 'package:crm/data/models/object_model.dart';
import 'package:crm/data/models/region_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_event.dart';

part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  ApiService apiService = ApiService();

  GeneralBloc() : super(GeneralState()) {
    on<GeneralInitialEvent>(_onGeneralInitialEvent);
  }

  _onGeneralInitialEvent(GeneralInitialEvent event, Emitter<GeneralState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await Future.wait([
        apiService.regions(),
        apiService.companies(),
        apiService.objects(),
        apiService.blocks(),
      ]);

      emit(state.copyWith(
        regions: (response)[0] as List<RegionModel>,
        companies: (response)[1] as List<CompanyModel>,
        objects: (response)[2] as List<ObjectModel>,
        blocs: (response)[3] as List<BlockModel>,
        status: Status.success,
      ));
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

String handlerError(DioException e) {
  if (e.type == DioExceptionType.connectionError) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Ulanish vaqt taym-aut';
      case DioExceptionType.sendTimeout:
        return 'Jo\'natish vaqt taym-aut';
      case DioExceptionType.receiveTimeout:
        return 'Qabul qilish vaqt taym-aut';
      case DioExceptionType.cancel:
        throw 'Bekor qilindi';
      case DioExceptionType.unknown:
        return 'Noma\'lum xatolik';
      case DioExceptionType.badCertificate:
        return 'Yomon sertifikat';
      case DioExceptionType.connectionError:
        return "Internet mavjud emas";
      case DioExceptionType.badResponse:
        return 'Yomon javob';
    }
  }
  return 'Noma\'lum';
}

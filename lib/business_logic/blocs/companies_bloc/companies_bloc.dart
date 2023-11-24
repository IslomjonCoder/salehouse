import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crm/data/models/company_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:meta/meta.dart';

part 'companies_event.dart';

part 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final ApiService _apiService = ApiService();

  CompaniesBloc() : super(CompaniesState()) {
    on<GetCompaniesEvent>(_onGetCompaniesEvent);
  }

  _onGetCompaniesEvent(GetCompaniesEvent event, Emitter<CompaniesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final companies = await _apiService.companies();
      emit(state.copyWith(status: Status.success, companies: companies));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

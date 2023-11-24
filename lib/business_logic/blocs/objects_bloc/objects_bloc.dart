import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crm/data/models/object_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:meta/meta.dart';

part 'objects_event.dart';

part 'objects_state.dart';

class ObjectsBloc extends Bloc<ObjectsEvent, ObjectsState> {
  ApiService apiService = ApiService();
  ObjectsBloc() : super(ObjectsState()) {
    on<GetObjectsEvent>(_getObjectsEvent);
  }

  _getObjectsEvent(GetObjectsEvent event, Emitter<ObjectsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<ObjectModel> objects = await apiService.objects();
      emit(state.copyWith(status: Status.success, objects: objects));
    }
    catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

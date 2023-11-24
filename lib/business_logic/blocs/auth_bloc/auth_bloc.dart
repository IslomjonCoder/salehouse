import 'dart:async';

import 'package:crm/data/models/user_token_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/device/device_utility.dart';
import 'package:crm/utils/exceptions/exceptions.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final ApiService _apiService = ApiService();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>(_onLogin);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    print('login ${event.login} ${event.password}');
    try {
      // await Future.delayed(const Duration(seconds: 2));
      // throw Exception('Incorrect login or password');
      final hasInternet = await TDeviceUtils.hasInternetConnection();
      if (!hasInternet) {
        emit(AuthLoginError(error: 'No internet connection'));
        return;
      }
      final userToken = await _apiService.login(event.login, event.password);
      TLocalStorage.saveString(loginKey, event.login);
      TLocalStorage.saveString(passwordKey, event.password);
      emit(AuthLoginSuccess(userToken: userToken));
    }
    on ErrorException catch (e) {
      print(e);
      emit(AuthLoginError(error: e.message));
    }
    catch (e) {
      print(e.runtimeType);
      if (e is ErrorException) {
        emit(AuthLoginError(error: e.message));
        return;
      }
      emit(AuthLoginError(error: e.toString()));
    }
  }
}

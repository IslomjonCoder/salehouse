part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final UserToken userToken;

  AuthLoginSuccess({required this.userToken});
}

class AuthLoginError extends AuthState {
  final String error;

  AuthLoginError({required this.error});
}

part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String login;
  final String password;

  AuthLogin({
    required this.login,
    required this.password,
  });
}

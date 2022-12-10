part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSigninEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSigninEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignupEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignupEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignoutEvent extends AuthEvent {}

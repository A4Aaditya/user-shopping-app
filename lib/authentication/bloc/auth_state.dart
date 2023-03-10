part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class LogoutState extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({
    required this.message,
  });
}

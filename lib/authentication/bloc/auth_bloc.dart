import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_user_shop_app/authentication/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSigninEvent>(_signin);
    on<AuthSignupEvent>(_signup);
    on<AuthSignoutEvent>(signout);
  }
  // signup

  FutureOr<void> _signup(AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await AuthRepository()
          .signupWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // signin

  FutureOr<void> _signin(AuthSigninEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await AuthRepository()
          .signinWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // signout

  FutureOr<void> signout(
      AuthSignoutEvent event, Emitter<AuthState> emit) async {
    try {
      await AuthRepository().signout();
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

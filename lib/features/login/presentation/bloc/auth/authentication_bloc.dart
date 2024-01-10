import 'package:bloc/bloc.dart';
import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:fake_store/features/login/domain/usecase/get_user.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<_GetAuthenticationStatus>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      if (serviceLocator<SharedPreferences>().getString('token') == null) {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
        ));
      }
      else {
        emit(state.copyWith(authenticationStatus: AuthenticationStatus.authenticated,));
      }

    });

    on<_AuthenticationLoginEvent>((event, emit) async {
      final response =
      await GetUserUseCase().call((event.username, event.password));

      response.either(
            (failure) {
          emit(state.copyWith(
              authenticationStatus: AuthenticationStatus.unauthenticated));
          event.onFailure('Failed to auth');
        },
            (user) {
            serviceLocator<SharedPreferences>()
                .setString('token', 'token')
                .then((_) {});


          emit(state.copyWith(
            authenticationStatus: AuthenticationStatus.authenticated,
            authenticatedUser: user,
          ));

          event.onSuccess();
        },
      );
    });
    on<_AuthenticationLogoutEvent>((event, emit) async {
      await serviceLocator<SharedPreferences>().remove('token');
      emit(const AuthenticationState(logoutStatus: LogoutStatus.loggedOut));
    });
    // on<_AuthenticationLogoutEvent>((event, emit) async {
    //   final pref = await SharedPreferences.getInstance();
    //   await pref.remove('token');
    //   emit(state.copyWith(authenticationStatus: AuthenticationStatus.unauthenticated));
    // });

  }
}

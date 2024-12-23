import 'dart:developer';

import 'package:blog_app/core/blocs/app_user_info_cubit/app_user_info_cubit.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepoImplementation authRepoImplementation;
  final AppUserInfoCubit? _appUserInfoCubit;
  AuthBloc({
    required this.authRepoImplementation,
    required AppUserInfoCubit? appUserInfoCubit,
  })  : _appUserInfoCubit = appUserInfoCubit,
        super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      emit(AuthRegisterLoading());
      final response = await authRepoImplementation.register(
        data: event.data,
        email: event.email,
        password: event.password,
      );
      response.fold((left) {
        emit(AuthRegisterFailed(left.message));
      }, (right) {
        emit(AuthRegisterSuccess(right.id));
      });
    });
    on<AuthLogin>((event, emit) async {
      emit(AuthLoginLoading());
      final response = await authRepoImplementation.login(
        email: event.email,
        password: event.password,
      );

      response.fold((left) {
        log(left.message);
        emit(AuthLoginFailed(left.message));
      }, (right) {
        log(right.email);
        emit(AuthLoginSuccess(right));
      });
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      emit(AuthLoginLoading());
      final response = await authRepoImplementation.getCurrentUserData();
      response.fold((left) {
        log(left.message);
        emit(AuthInitial());
      }, (right) {
        log(right!.name);
        emitAuthSuccess(right, emit);
      });
    });
  }

  void emitAuthSuccess(UserModel user, Emitter<AuthState> emit) {
    _appUserInfoCubit?.updateUser(user);

    emit(AuthLoginSuccess(user));
  }
}

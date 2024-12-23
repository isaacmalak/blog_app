import 'package:blog_app/core/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_info_state.dart';

class AppUserInfoCubit extends Cubit<AppUserInfoState> {
  AppUserInfoCubit() : super(AppUserInfoInitial());
  void updateUser(UserModel? user) {
    if (user == null) {
      emit(AppUserInfoInitial());
    } else {
      emit(AppUserInfoLoggedIn(user: user));
    }
  }
}

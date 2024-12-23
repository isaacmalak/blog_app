part of 'app_user_info_cubit.dart';

@immutable
sealed class AppUserInfoState {}

final class AppUserInfoInitial extends AppUserInfoState {}

final class AppUserInfoLoggedIn extends AppUserInfoState {
  final UserModel user;

  AppUserInfoLoggedIn({required this.user});
}

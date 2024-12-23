part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Login
final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final UserModel user;
  AuthLoginSuccess(
    this.user,
  );
}

final class AuthLoginFailed extends AuthState {
  final String errorMessage;
  AuthLoginFailed(this.errorMessage);
}

// Register
final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterSuccess extends AuthState {
  final String userID;
  AuthRegisterSuccess(this.userID);
}

final class AuthRegisterFailed extends AuthState {
  final String errorMessage;
  AuthRegisterFailed(this.errorMessage);
}

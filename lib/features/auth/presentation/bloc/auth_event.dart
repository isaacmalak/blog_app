part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthRegister extends AuthEvent {
  final Map<String, dynamic> data;
  final String? name;
  final String email;
  final String password;

  AuthRegister({
    this.name,
    required this.data,
    required this.email,
    required this.password,
  });
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

import 'dart:developer';
import 'package:blog_app/core/failures/failuer.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/features/auth/data/repos/auth_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImplementation implements AuthRepo {
  final SupabaseClient _supabaseClient;

  AuthRepoImplementation(this._supabaseClient);

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      log(response.toString());
      if (response.user == null) {
        return left(Failure('user is null'));
      }
      return right(UserModel.fromJson(response.user!.toJson()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    Map<String, dynamic>? data,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        data: data,
        email: email,
        password: password,
      );
      log(response.user!.email.toString());
      if (response.user == null) {
        return left(Failure('failed to create user'));
      }
      log(response.user!.email.toString());
      return right(UserModel.fromJson(response.user!.toJson()));
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }

  @override
  Session? get currentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<Either<Failure, UserModel?>> getCurrentUserData() async {
    try {
      if (currentUserSession == null) {
        return left(Failure('There is no user session'));
      }
      final userData = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
      return right(UserModel.fromJson(userData.first));
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }
}

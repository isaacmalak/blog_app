import 'package:blog_app/core/failures/failuer.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Session? get currentUserSession;
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password});
  Future<Either<Failure, UserModel>> register({
    Map<String, dynamic> data,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel?>> getCurrentUserData();
}

import 'dart:developer';

import 'package:blog_app/core/failures/failuer.dart';
import 'package:blog_app/core/models/blog.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ViewBlogsRepo {
  Future<Either<Failure, List<BlogModel>>> fetchBlogs();
}

class ViewBlogsImp extends ViewBlogsRepo {
  final SupabaseClient _supabaseClient;

  ViewBlogsImp(this._supabaseClient);

  @override
  Future<Either<Failure, List<BlogModel>>> fetchBlogs() async {
    try {
      final response =
          await _supabaseClient.from('blogs').select('*, profiles(name)');
      final List<BlogModel> blogs = [];
      for (var i = 0; i < response.length; i++) {
        blogs.add(BlogModel.fromJson(response[i]).copyWith(
          userName: response[i]['profiles']['name'],
          topics:  List<String>.from(response[i]['topics'] as List),
        ));
      }
      return right(blogs);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }
}

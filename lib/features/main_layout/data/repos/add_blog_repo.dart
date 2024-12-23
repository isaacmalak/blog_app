import 'dart:io';

import 'package:blog_app/core/failures/failuer.dart';
import 'package:blog_app/core/models/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AddBlogRepo {
  Future<Either<Failure, BlogModel>> addBlog({
    required String title,
    required String content,
    required List<String>? topics,
    required String? image_url,
    required String user_id,
    required File? image,
    required String? linkedInUrl,
    required String? mediumUrl,
  });
  Future<String> uploadImage({required File image, required BlogModel blog});
}

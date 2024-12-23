import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/failures/failuer.dart';
import 'package:blog_app/core/models/blog.dart';
import 'package:blog_app/features/main_layout/data/repos/add_blog_repo.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AddBlogRepoImpl implements AddBlogRepo {
  final SupabaseClient _supabaseClient;

  AddBlogRepoImpl(this._supabaseClient);

  @override
  Future<Either<Failure, BlogModel>> addBlog({
    required String title,
    required String content,
    required List<String>? topics,
    // ignore: non_constant_identifier_names
    required String? image_url,
    // ignore: non_constant_identifier_names
    required String user_id,
    required File? image,
    required String? linkedInUrl,
    required String? mediumUrl,
  }) async {
    try {
      BlogModel blog = BlogModel(
          title: title,
          content: content,
          topics: topics ?? [],
          imageUrl: image_url ?? '',
          userId: user_id,
          linkedInUrl: linkedInUrl,
          mediumUrl:  mediumUrl,
          );
      String? imageUrl;
      final response = await _supabaseClient.from('blogs').insert({
        'title': title,
        'content': content,
        'topics': topics ?? [],
        'image_url': image_url ?? '',
        'user_id': user_id,
        'linkedIn_link': linkedInUrl,
        'medium_link': mediumUrl,
      }).select();

      blog.copyWith(
        id: response.first['id'].toString(),
        date: response.first['date'],
        image_url: imageUrl ?? '',
      );
      if (image != null) {
        imageUrl = await uploadImage(
            image: image, blog: BlogModel.fromJson(response.first));
        log('image url => $imageUrl');
        await _supabaseClient.from('blogs').update({
          'image_url': imageUrl,
        }).eq('id', response.first['id']);
      }
      log('response Id =>${response.first['id']}');

      return right(BlogModel.fromJson(response.first));
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<String> uploadImage(
      {required File image, required BlogModel blog}) async {
    try {
      final newName = const Uuid().v1();
      await _supabaseClient.storage.from('blog_images').upload(
            '${blog.id}/$newName',
            image,
          );
      return _supabaseClient.storage
          .from('blog_images')
          .getPublicUrl('${blog.id}/$newName');
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}

import 'dart:io';

import 'package:blog_app/features/main_layout/data/repos/add_blog_repo_impl.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_blog_event.dart';
part 'add_blog_state.dart';

class AddBlogBloc extends Bloc<AddBlogEvent, AddBlogState> {
  final AddBlogRepoImpl addBlogRepoImpl;
  AddBlogBloc(this.addBlogRepoImpl) : super(AddBlogInitial()) {
    on<AddBlogEvent>((event, emit) {
      emit(AddBlogLoading());
    });
    on<AddBlog>(
      (event, emit) async {
        final response = await addBlogRepoImpl.addBlog(
          title: event.title,
          content: event.content,
          topics: event.topics,
          image_url: event.image_url,
          user_id: event.user_id,
          image: event.image,
          linkedInUrl: event.linkedInUrl,
          mediumUrl: event.mediumUrl,
        );
        response.fold((left) {
          emit(AddBlogFailure(left.message));
        }, (right) {
          emit(AddBlogSuccess());
        });
      },
    );
  }
}

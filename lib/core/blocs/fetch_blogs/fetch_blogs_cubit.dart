import 'dart:developer';

import 'package:blog_app/core/models/blog.dart';
import 'package:blog_app/features/main_layout/data/repos/view_blogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_blogs_state.dart';

class FetchBlogsCubit extends Cubit<FetchBlogsState> {
  FetchBlogsCubit(this.viewBlogsImp) : super(FetchBlogsInitial());
  ViewBlogsImp viewBlogsImp;
  void fetchBlogs() {
    emit(FetchBlogsLoading());
    try {
      viewBlogsImp.fetchBlogs().then((value) {
        value.fold((l) {
          log(l.toString());
          emit(FetchBlogsFailure(l.toString()));
        }, (r) {
          log(r.toString());
          emit(FetchBlogsSuccess(r));
        });
      });
    } catch (e) {
      emit(FetchBlogsFailure(e.toString()));
    }
  }
}

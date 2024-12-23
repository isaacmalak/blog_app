part of 'fetch_blogs_cubit.dart';

@immutable
sealed class FetchBlogsState {}

final class FetchBlogsInitial extends FetchBlogsState {}

final class FetchBlogsLoading extends FetchBlogsState {}

final class FetchBlogsSuccess extends FetchBlogsState {
  final List<BlogModel> blogs;
  FetchBlogsSuccess(this.blogs);
}

final class FetchBlogsFailure extends FetchBlogsState {
  final String errorMessage;
  FetchBlogsFailure(this.errorMessage);
}

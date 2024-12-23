part of 'add_blog_bloc.dart';

@immutable
sealed class AddBlogState {}

final class AddBlogInitial extends AddBlogState {}

final class AddBlogLoading extends AddBlogState {}

final class AddBlogSuccess extends AddBlogState {}

final class AddBlogFailure extends AddBlogState {
  final String errorMessage;
  AddBlogFailure(this.errorMessage);
}

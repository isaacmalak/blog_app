part of 'add_blog_bloc.dart';

@immutable
sealed class AddBlogEvent {}

final class AddBlog extends AddBlogEvent {
  AddBlog({
    required this.title,
    required this.content,
    required this.topics,
    required this.image_url,
    required this.user_id,
    required this.image,
    required this.linkedInUrl,
    required this.mediumUrl,
  });
  final String title;
  final String content;
  final List<String>? topics;
  final String? image_url;
  final String user_id;
  final File? image;
  final String? linkedInUrl;

  final String? mediumUrl;
}

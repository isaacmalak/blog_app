import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogImage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BlogImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<BlogImage> createState() => _BlogImageState();
}

class _BlogImageState extends State<BlogImage> {
  Size? imageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          placeholderFadeInDuration: const Duration(milliseconds: 500),
          fit: BoxFit.cover,
          imageUrl: widget.imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }
}

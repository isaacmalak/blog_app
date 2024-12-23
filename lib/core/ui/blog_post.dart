import 'dart:developer';

import 'package:blog_app/core/models/blog.dart';
import 'package:blog_app/core/ui/drop_cap_text.dart';
import 'package:blog_app/core/ui/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPost extends StatefulWidget {
  const BlogPost({super.key, required this.blog, required this.color});
  final Color color;
  final BlogModel blog;

  @override
  State<BlogPost> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> with TickerProviderStateMixin {
  Animation? heightAnimation;
  Animation? colorAnimation;
  AnimationController? animationController;
  bool isTapped = false;
  Future<void> _launchUrl({required String url}) async {
    final Uri urlParsed = Uri.parse(url);
    log(urlParsed.toString());
    if (!await launchUrl(urlParsed, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch the Link : $urlParsed");
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    heightAnimation =
        Tween<double>(begin: .45, end: 1).animate(animationController!);

    colorAnimation = ColorTween(
            begin: widget.color, end: const Color.fromARGB(255, 74, 27, 56))
        .animate(animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: heightAnimation!,
        builder: (context, _) {
          return InkWell(
            onTap: () {
              if (isTapped) {
                animationController!.reverse();
                setState(() {
                  isTapped = false;
                });
              } else {
                animationController!.forward();
                setState(() {
                  isTapped = true;
                });
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              constraints: BoxConstraints(
                  maxHeight: size.height * heightAnimation!.value,
                  maxWidth: 400),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorAnimation!.value,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            widget.blog.title,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (widget.blog.linkedInUrl != null &&
                              widget.blog.linkedInUrl!.isNotEmpty)
                            TextButton.icon(
                              style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fixedSize:
                                      WidgetStatePropertyAll(Size(150, 15)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () async {
                                Uri url = Uri.parse(widget.blog.linkedInUrl!);
                                if (await canLaunchUrl(url)) {
                                  if (widget.blog.linkedInUrl!
                                      .startsWith('http')) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                    log(widget.blog.linkedInUrl.toString());
                                  } else {
                                    await launchUrl(
                                      Uri.parse(
                                          "https://$widget.blog.linkedInUrl"),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                } else {
                                  log('Could not launch ${widget.blog.linkedInUrl}');
                                }
                              },
                              icon: const Icon(Icons.link),
                              label: const Text('LinkedIn Post'),
                            ),
                          if (widget.blog.mediumUrl != null &&
                              widget.blog.mediumUrl!.isNotEmpty)
                            TextButton.icon(
                              style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fixedSize:
                                      WidgetStatePropertyAll(Size(150, 15)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () async {
                                Uri url = Uri.parse(widget.blog.mediumUrl!);
                                if (await canLaunchUrl(url)) {
                                  if (widget.blog.mediumUrl!
                                      .startsWith('http')) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                    log(widget.blog.mediumUrl.toString());
                                  } else {
                                    await launchUrl(
                                      Uri.parse(
                                          "https://$widget.blog.mediumUrl"),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                } else {
                                  log('Could not launch ${widget.blog.linkedInUrl}');
                                }
                              },
                              icon: const Icon(Icons.link),
                              label: const Text('Medium Blog'),
                            ),
                        ],
                      ),

                      if (widget.blog.topics != null)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            children: [
                              Row(
                                children: widget.blog.topics!.map((e) {
                                  return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Chip(label: Text(e)));
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      if (widget.blog.imageUrl?.isNotEmpty == true)
                        DropCapText(
                          dropCap: BlogImage(imageUrl: widget.blog.imageUrl!),
                          dropCapPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          text: widget.blog.content,
                          textStyle: const TextStyle(),
                        ),
                      if (widget.blog.imageUrl!.isEmpty)
                        Text(widget.blog.content),
                      //TextDrop(text: blog.content, imageUrl: blog.imageUrl),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text('1 min'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

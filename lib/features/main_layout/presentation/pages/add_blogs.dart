import 'dart:io';

import 'package:blog_app/core/common/file_picker.dart';
import 'package:blog_app/core/blocs/add_blog_bloc/bloc/add_blog_bloc.dart';
import 'package:blog_app/core/blocs/app_user_info_cubit/app_user_info_cubit.dart';
import 'package:blog_app/core/ui/custom_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogs extends StatefulWidget {
  const AddBlogs({super.key});

  @override
  State<AddBlogs> createState() => _AddBlogsState();
}

class _AddBlogsState extends State<AddBlogs> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _linkedInLinkController = TextEditingController();
  final TextEditingController _mediumLinkController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final selectedTopics = <String>[];
  File? selectedImage;
  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    _linkedInLinkController.dispose();
    _mediumLinkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddBlogBloc, AddBlogState>(
      listener: (context, state) {
        if (state is AddBlogSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'You have added the blog successfully',
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        } else if (state is AddBlogFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AddBlogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        'Add a Blog',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(onTap: () async {
                      final image = await pickImage();
                      if (image != null) {
                        selectedImage = image;
                        setState(() {});
                      }
                    }, child: () {
                      if (selectedImage != null) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedImage!,
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      } else {
                        return DottedBorder(
                          strokeCap: StrokeCap.round,
                          dashPattern: const [
                            10,
                            4,
                          ],
                          radius: const Radius.circular(24),
                          borderType: BorderType.RRect,
                          color: Colors.white,
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Add a photo',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )),
                          ),
                        );
                      }
                    }()),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Bussiness',
                    'Science',
                    'Art',
                    'Wizards'
                  ].map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(6.5),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedTopics.contains(e)) {
                            selectedTopics.remove(e);
                          } else {
                            selectedTopics.add(e);
                          }
                          setState(() {});
                        },
                        child: Chip(
                          backgroundColor: selectedTopics.contains(e)
                              ? const Color.fromARGB(255, 113, 14, 47)
                              : null,
                          label: Text(e),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfield(
                      title: 'LinkedIn post Link (if exsit)',
                      hintText: 'https://www.linkedin.com/in/isaacmalak',
                      controller: _linkedInLinkController,
                      validator: (val) {
                        if (val!.contains('linkedin')) {
                          if (val.length < 5) {
                            return 'This probably not a valid link';
                          }
                          return null;
                        } else {
                          return 'Please enter a valid LinkedIn link';
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      title: 'Mediam blog Link (if exsit)',
                      hintText: 'https://medium.com....',
                      controller: _mediumLinkController,
                      validator: (val) {
                        if (val!.contains('medium')) {
                          if (val.length < 5) {
                            return 'This probably not a valid link';
                          }
                          return null;
                        } else {
                          return 'Please enter a valid Medium link';
                        }
                      },
                    ),
                    CustomTextfield(
                      title: 'Subject',
                      hintText: 'Can wizards fit in the modern world?',
                      controller: _subjectController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter the Subject of the blog';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      title: 'Content',
                      hintText: 'Wizards should be canceled...',
                      controller: _contentController,
                      minLines: 6,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter the Content of the blog';
                        } else {
                          if (val.length < 180) {
                            return 'This blogs looks short, try to some points to your blog';
                          }
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final userId = (context
                                      .read<AppUserInfoCubit>()
                                      .state as AppUserInfoLoggedIn)
                                  .user
                                  .id;
                              context.read<AddBlogBloc>().add(AddBlog(
                                    mediumUrl:
                                        _mediumLinkController.text.trim(),
                                    linkedInUrl:
                                        _linkedInLinkController.text.trim(),
                                    title: _subjectController.text.trim(),
                                    content: _contentController.text.trim(),
                                    topics: selectedTopics,
                                    image: selectedImage,
                                    image_url: '',
                                    user_id: userId,
                                  ));
                            }
                          },
                          child: const Text('Add Blog'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 400)
              //TODO: scroll on the textField
            ],
          ),
        );
      },
    );
  }
}

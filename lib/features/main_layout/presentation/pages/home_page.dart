import 'package:blog_app/core/blocs/fetch_blogs/fetch_blogs_cubit.dart';
import 'package:blog_app/core/ui/blog_post.dart';
import 'package:blog_app/features/main_layout/presentation/pages/add_blogs.dart';
import 'package:blog_app/features/main_layout/presentation/pages/curved_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(key: key ?? const ValueKey<String>('home page key'));

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<FetchBlogsCubit>().fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
body: BlocConsumer<FetchBlogsCubit, FetchBlogsState>(
          listener: (context, state) {
            if (state is FetchBlogsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              )));
            }
          },
          builder: (context, state) {
            if (state is FetchBlogsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FetchBlogsSuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogPost(
                    blog: blog,
                    color: const Color.fromARGB(255, 82, 38, 183),
                  );
                },
              );
            }
            return const Center(child: Text('Oops something went wrong'));
          },
        ));
  }
}

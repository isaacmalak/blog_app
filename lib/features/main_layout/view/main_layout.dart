import 'package:blog_app/features/main_layout/presentation/pages/add_blogs.dart';
import 'package:blog_app/features/main_layout/presentation/pages/curved_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyCurvedDrawer(),
      body: navigationShell,
      appBar: AppBar(
        title: Text(
            Supabase.instance.client.auth.currentUser!.userMetadata!['name']),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  context: context,
                  sheetAnimationStyle: AnimationStyle(
                      duration: const Duration(seconds: 1), curve: Curves.ease),
                  builder: (context) {
                    return const AddBlogs();
                  });
            },
            icon: const Icon(CupertinoIcons.text_badge_plus),
            //TODO: change the icon to a better one
          ),
        ],
      ),
    );
  }
}

import 'package:blog_app/core/routes/router.dart';
import 'package:blog_app/features/main_layout/data/repos/drawer_index_cubit/drawer_index_cubit.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyCurvedDrawer extends StatefulWidget {
  const MyCurvedDrawer({
    super.key,
  });

  @override
  State<MyCurvedDrawer> createState() => _MyCurvedDrawerState();
}

var _index = 0;

class _MyCurvedDrawerState extends State<MyCurvedDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerIndexCubit, int>(
      listener: (context, selectedIndex) {
        _index = selectedIndex;
      },
      child: CurvedDrawer(
        color: const Color.fromARGB(255, 31, 9, 72),
        buttonBackgroundColor: const Color.fromARGB(255, 178, 89, 255),
        animationCurve: Curves.ease,
        labelColor: Colors.white,
        backgroundColor: Colors.transparent,
        width: 100,
        index: _index,
        items: const <DrawerItem>[
          DrawerItem(icon: Icon(Icons.home)),
          DrawerItem(icon: Icon(Icons.person)),
          DrawerItem(icon: Icon(Icons.info)),
        ],
        onTap: (index) {
          if (index == 0) {
            setState(() {
              _index = index;
            });
            AppRouter.router.goNamed('home');
          } else if (index == 1) {
            setState(() {
              _index = index;
            });
            GoRouter.of(context).goNamed('profile');
          } else if (index == 2) {
            setState(() {
              _index = index;
            });
            AppRouter.router.goNamed('info');
          }
        },
      ),
    );
  }
}

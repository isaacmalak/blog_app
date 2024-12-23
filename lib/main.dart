import 'package:blog_app/core/blocs/add_blog_bloc/bloc/add_blog_bloc.dart';
import 'package:blog_app/core/blocs/app_user_info_cubit/app_user_info_cubit.dart';
import 'package:blog_app/core/blocs/fetch_blogs/fetch_blogs_cubit.dart';
import 'package:blog_app/core/routes/router.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/main_layout/data/repos/drawer_index_cubit/drawer_index_cubit.dart';
import 'package:blog_app/features/main_layout/presentation/pages/curved_drawer.dart';
import 'package:blog_app/features/main_layout/view/main_layout.dart';
import 'package:blog_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserInfoCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AddBlogBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<FetchBlogsCubit>(),
      ),
      BlocProvider(
        create: (context) => DrawerIndexCubit(),
        child: const MyCurvedDrawer(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    serviceLocator<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      title: 'Flutter Demo',
      routerConfig: AppRouter.router,
    );
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme.darkThemeMode,
    //   title: 'Flutter Demo',
    //   routerConfig: AppRouter.createRouter(context),
    // );
  }
}

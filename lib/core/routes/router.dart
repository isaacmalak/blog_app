import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/main_layout/presentation/pages/home_page.dart';
import 'package:blog_app/features/main_layout/view/info_view.dart';
import 'package:blog_app/features/main_layout/view/main_layout.dart';
import 'package:blog_app/features/main_layout/view/profile_view/profile_page.dart';
import 'package:blog_app/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final navigatorkey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    routes: routes,
    initialLocation: '/loading',
    navigatorKey: navigatorkey,
  );
}

List<RouteBase> routes = [
  GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthLoginSuccess) {
                AppRouter.router.go('/home');
              } else if (state is AuthInitial) {
                AppRouter.router.go('/login');
              }
            },
            child: const LoginPage(),
            //TODO: Test this code on the login page after making the logout button
          ),
        );
      }),
  GoRoute(
      path: '/signup',
      name: 'signup',
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const SignUpPage())),
  StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) =>
                MaterialPage(key: state.pageKey, child: const HomePage())),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ProfilePage(),
          ),
        ),
        GoRoute(
          path: '/info',
          name: 'info',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const InfoPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween); 
              
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        )
      ])
    ],
    builder: (context, state, navigationShell) {
      return MainLayout(navigationShell: navigationShell);
    },
  ),
  GoRoute(
      path: '/loading',
      name: 'loading',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              await Future.delayed(const Duration(seconds: 1));
              if (state is AuthLoginSuccess) {
                AppRouter.router.go('/home');
              } else if (state is AuthInitial) {
                AppRouter.router.go('/login');
              }
            },
            child: const SplashScreen(),
          ),
        );
      }),
];

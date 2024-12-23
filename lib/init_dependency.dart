import 'package:blog_app/core/blocs/add_blog_bloc/bloc/add_blog_bloc.dart';
import 'package:blog_app/core/blocs/app_user_info_cubit/app_user_info_cubit.dart';
import 'package:blog_app/core/blocs/fetch_blogs/fetch_blogs_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/main_layout/data/repos/add_blog_repo_impl.dart';
import 'package:blog_app/features/main_layout/data/repos/view_blogs.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(() {
    return supabase.client;
  });
  _initAuth();
  _viewBlogs();
  _initBlog();
}

void _initAuth() {
  // Repo implementation
  serviceLocator.registerFactory<AuthRepoImplementation>(
    () => AuthRepoImplementation(
      serviceLocator(),
    ),
  );
  //app user info cubit
  serviceLocator.registerLazySingleton<AppUserInfoCubit>(
    () => AppUserInfoCubit(),
  );
  //Auth Bloc
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      authRepoImplementation: serviceLocator(),
      appUserInfoCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<AddBlogRepoImpl>(() {
      return AddBlogRepoImpl(serviceLocator());
    })
    ..registerLazySingleton<AddBlogBloc>(() {
      return AddBlogBloc(serviceLocator());
    });
}

void _viewBlogs() {
  serviceLocator.registerFactory<ViewBlogsImp>(
    () => ViewBlogsImp(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchBlogsCubit(serviceLocator()),
  );
}

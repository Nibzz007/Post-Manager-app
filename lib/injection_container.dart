import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:post_manager_app/core/database/database_helper.dart';
import 'package:post_manager_app/core/network/dio_client.dart';
import 'package:post_manager_app/data/datasources/local/favorites_local_datasource.dart';
import 'package:post_manager_app/data/datasources/local/favorites_local_datasource_impl.dart';
import 'package:post_manager_app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:post_manager_app/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:post_manager_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:post_manager_app/data/datasources/remote/movie_remote_datasource_impl.dart';
import 'package:post_manager_app/data/repositories/auth_repository_impl.dart';
import 'package:post_manager_app/data/repositories/favorites_repository_impl.dart';
import 'package:post_manager_app/data/repositories/movie_repository_impl.dart';
import 'package:post_manager_app/data/repositories/post_repository_impl.dart';
import 'package:post_manager_app/domain/repositories/auth_repository.dart';
import 'package:post_manager_app/domain/repositories/favorites_repository.dart';
import 'package:post_manager_app/domain/repositories/movie_repository.dart';
import 'package:post_manager_app/domain/repositories/post_repository.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:post_manager_app/presentation/movies/bloc/movie_bloc.dart';
import 'package:post_manager_app/presentation/post/bloc/post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  //! Core
  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton(() => DatabaseHelper());

  //! Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sl()),
  );

  //! Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl(), sl()),
  );

  //! BLoCs / Cubits
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => FavoritesBloc(sl()));
  sl.registerFactory(() => PostBloc(sl()));
}

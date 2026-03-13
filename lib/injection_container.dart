import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:post_manager_app/core/database/database_helper.dart';
import 'package:post_manager_app/core/network/dio_client.dart';
import 'package:post_manager_app/data/post_repository_impl.dart';
import 'package:post_manager_app/domain/post_repository.dart';
import 'package:post_manager_app/presentation/bloc/post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! 1. Presentation Layer (BLoC)
  // We use registerFactory because we want a NEW instance of BLoC
  // every time a page is opened (to reset state).
  sl.registerFactory(() => PostBloc(sl()));

  //! 2. Domain Layer (Repositories)
  // We use LazySingleton because we only ever need ONE repository
  // for the whole life of the app. It only creates it when someone asks for it.
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl(), sl()),
  );

  //! 3. Core Layer (Network & Database)
  // Register our custom DioClient
  sl.registerLazySingleton(() => DioClient(sl()));

  // Register our sqflite Helper
  sl.registerLazySingleton(() => DatabaseHelper());

  //! 4. External Packages
  // We inject the raw Dio instance into our DioClient
  sl.registerLazySingleton(() => Dio());
}

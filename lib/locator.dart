import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/local/app_prefs.dart';
import 'core/local/token_store.dart';
import 'core/network/api_provider.dart';
import 'core/network/api_provider_impl.dart';
import 'core/network/internet_bloc/internet_bloc.dart';
import 'core/network/network.dart';
import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/projects/data/datasources/remote/project_remote_datasource.dart';
import 'features/projects/data/repository_impl/project_repository_impl.dart';
import 'features/projects/domain/repositories/project_repository.dart';
import 'features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';

final locator = GetIt.instance;
String documentsDir = '';

Future<void> initLocator() async {
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  locator.registerLazySingleton<Store>(() => Store(locator()));

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  locator.registerFactory<ApiProvider>(() => ApiProviderImpl());

  final internetChecker = InternetConnectionChecker.instance;
  locator.registerSingleton<InternetBloc>(InternetBloc(internetChecker));

  final sharedPrefs = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  locator.registerLazySingleton<AppPreferences>(
    () => AppPreferences(locator()),
  );

  ///data sources
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(apiProvider: locator()),
  );
  locator.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(locator()),
  );

  ///repository

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthRepositoryImpl(locator(), locator()),
  );

  locator.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(locator(), locator()),
  );

  ///usecase

  locator.registerLazySingleton(() => LoginUseCase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));

  ///bloc
  locator.registerSingleton<AuthBloc>(AuthBloc(locator(), locator()));
  locator<AuthBloc>().add(CheckAuthEvent());

  locator.registerSingleton<ProjectsBloc>(ProjectsBloc(locator()));
  locator.registerSingleton<ProjectDetailsBloc>(ProjectDetailsBloc());

}

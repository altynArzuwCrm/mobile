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
import 'features/clients/data/datasources/remote/client_datasources.dart';
import 'features/clients/data/repositories/client_repository_impl.dart';
import 'features/clients/domain/repositories/client_repository.dart';
import 'features/clients/presentation/cubits/client_details/client_details_cubit.dart';
import 'features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'features/projects/data/datasources/remote/project_remote_datasource.dart';
import 'features/projects/data/repository_impl/project_repository_impl.dart';
import 'features/projects/domain/repositories/project_repository.dart';
import 'features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'features/users/data/datasources/remote/user_datasources.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'features/users/presentation/cubits/user/user_cubit.dart';
import 'features/users/presentation/cubits/user_details/user_details_cubit.dart';
import 'features/users/presentation/cubits/user_list/user_list_cubit.dart';

final locator = GetIt.instance;
String documentsDir = '';

Future<void> initLocator() async {

  final internetChecker = InternetConnectionChecker.createInstance(
    addresses: [
      AddressCheckOption(uri: Uri.parse('https://www.google.com/')),
    ],
  );

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  locator.registerLazySingleton<Store>(() => Store(locator()));

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetChecker));

  locator.registerFactory<ApiProvider>(() => ApiProviderImpl());

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
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<ClientRemoteDataSource>(
    () => ClientRemoteDataSourceImpl(locator()),
  );

  ///repository

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthRepositoryImpl(locator(), locator()),
  );

  locator.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(locator(), locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator(), locator()),
  );
  locator.registerLazySingleton<ClientRepository>(
    () => ClientRepositoryImpl(locator(), locator()),
  );

  ///usecase

  locator.registerLazySingleton(() => LoginUseCase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));

  ///bloc
  locator.registerSingleton<AuthBloc>(AuthBloc(locator(), locator()));
  locator<AuthBloc>().add(CheckAuthEvent());

  locator.registerSingleton<ProjectsBloc>(ProjectsBloc(locator()));
  locator.registerSingleton<ProjectDetailsBloc>(ProjectDetailsBloc());

  locator.registerSingleton<UserCubit>(UserCubit());
  locator.registerSingleton<UserListCubit>(UserListCubit(locator()));
  locator.registerSingleton<UserDetailsCubit>(UserDetailsCubit());
  locator.registerSingleton<ClientsCubit>(ClientsCubit());
  locator.registerSingleton<ClientDetailsCubit>(ClientDetailsCubit());
}

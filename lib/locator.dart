import 'package:crm/features/assignments/data/datasources/assignment_datasources.dart';
import 'package:crm/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:crm/features/stages/data/datasources/stage_datasources.dart';
import 'package:crm/features/stages/data/repositories/stage_repository.dart';
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
import 'features/assignments/data/repositories/assignment_repository.dart';
import 'features/assignments/presentation/cubits/assign_cubit.dart';
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
import 'features/clients/presentation/cubits/companies/company_cubit.dart';
import 'features/clients/presentation/cubits/company_details/company_detail_cubit.dart';
import 'features/notifications/data/datasources/notification_remote_datasource.dart';
import 'features/notifications/data/repository/notification_repository.dart';
import 'features/notifications/presentation/cubits/notifications/notification_cubit.dart';
import 'features/orders/data/repositories/order_repository.dart';
import 'features/orders/presentation/cubits/comment/comment_cubit.dart';
import 'features/orders/presentation/cubits/order_details/order_detail_cubit.dart';
import 'features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'features/products/data/datasources/product_datasource.dart';
import 'features/products/data/repositories/product_repository.dart';
import 'features/products/presentation/cubits/products/products_cubit.dart';
import 'features/projects/data/datasources/remote/project_remote_datasource.dart';
import 'features/projects/data/repository_impl/project_repository_impl.dart';
import 'features/projects/domain/repositories/project_repository.dart';
import 'features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'features/roles/data/datasources/role_remote_datasource.dart';
import 'features/roles/data/repository/role_repository.dart';
import 'features/roles/presentation/cubits/roles/roles_cubit.dart';
import 'features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'features/stages/presentation/cubits/stage_with_users/stage_with_users_cubit.dart';
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
    addresses: [AddressCheckOption(uri: Uri.parse('https://www.google.com/'))],
  );

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  locator.registerLazySingleton<Store>(() => Store(locator()));

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetChecker),
  );

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

  locator.registerLazySingleton<StageRemoteDataSources>(
    () => StageRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<RoleRemoteDatasource>(
    () => RoleRemoteDatasourceImpl(locator()),
  );

  // locator.registerLazySingleton<AssignmentDataSources>(
  //   () => AssignmentDataSourcesImpl(locator()),
  // );

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
  locator.registerLazySingleton<StageRepository>(
    () => StageRepository(locator(), locator()),
  );
  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepository(locator(), locator()),
  );
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepository(locator(), locator()),
  );
  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(locator(), locator()),
  );

  locator.registerLazySingleton<RoleRepository>(
    () => RoleRepository(locator(), locator()),
  );

  // locator.registerLazySingleton<AssignmentRepository>(
  //   () => AssignmentRepository(locator(), locator()),
  // );

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
  locator.registerSingleton<ClientsCubit>(ClientsCubit(locator()));
  locator.registerSingleton<ClientDetailsCubit>(ClientDetailsCubit());
  locator.registerSingleton<StageCubit>(StageCubit(locator()));

  locator.registerSingleton<OrdersCubit>(OrdersCubit(locator(), locator()));
  locator.registerSingleton<OrderDetailCubit>(OrderDetailCubit(locator()));
  locator.registerSingleton<CommentCubit>(CommentCubit(locator()));
  locator.registerSingleton<ProductsCubit>(ProductsCubit(locator()));
  locator.registerSingleton<NotificationCubit>(NotificationCubit(locator()));
  locator.registerSingleton<RolesCubit>(RolesCubit(locator()));
  locator.registerSingleton<CompanyCubit>(CompanyCubit());
  locator.registerSingleton<CompanyDetailCubit>(CompanyDetailCubit());
  locator.registerSingleton<StageWithUsersCubit>(StageWithUsersCubit(locator()));

  // locator.registerSingleton<AssignCubit>(AssignCubit(locator()));



}


import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/api_provider.dart';
import 'core/network/api_provider_impl.dart';
import 'core/network/internet_bloc/internet_bloc.dart';
import 'core/network/network.dart';

final locator = GetIt.instance;
String documentsDir = '';

Future<void> initLocator() async {
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  locator.registerFactory<ApiProvider>(() => ApiProviderImpl());

  final internetChecker = InternetConnectionChecker.instance;
  locator.registerSingleton<InternetBloc>(InternetBloc(internetChecker));
}

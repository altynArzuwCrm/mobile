import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/config/routes/app_router.dart';
import '../core/network/internet_bloc/internet_bloc.dart';

import 'core/config/theme/app_theme.dart';
import 'core/constants/strings/app_strings.dart';
import 'locator.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(
            create: (context) => locator<InternetBloc>()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
      ),
    );
  }
}

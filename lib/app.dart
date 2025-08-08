import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../core/config/routes/app_router.dart';
import '../core/network/internet_bloc/internet_bloc.dart';

import 'common/widgets/scroll_behavior.dart';
import 'core/config/theme/app_theme.dart';
import 'core/constants/strings/app_strings.dart';
import 'features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'locator.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetBloc>(
              create: (context) => locator<InternetBloc>()),

          BlocProvider<AuthBloc>(
            create: (context) => locator<AuthBloc>(),
          ),

          BlocProvider<ProjectsBloc>(
            create: (context) => locator<ProjectsBloc>(),
          ),

        ],
        child: MaterialApp.router(
          title: AppStrings.splashName,
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          scrollBehavior: const NoGlowScrollBehavior(),
          routerConfig: goRouter,
        ),
      ),
    );
  }
}

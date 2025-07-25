import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/config/routes/scaffold_with_nested_nav.dart';
import 'package:crm/core/config/routes/widget_keys_str.dart';
import 'package:crm/features/auth/presentation/pages/change_password_page.dart';
import 'package:crm/features/auth/presentation/pages/confirm_password_page.dart';
import 'package:crm/features/auth/presentation/pages/new_password_page.dart';
import 'package:crm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:crm/features/auth/presentation/pages/sign_up_page.dart';
import 'package:crm/features/details/presentation/pages/details_page.dart';
import 'package:crm/features/main/presentation/pages/main_page.dart';
import 'package:crm/features/orders/presentation/pages/orders_page.dart';
import 'package:crm/features/orders/presentation/pages/user_order_page.dart';
import 'package:crm/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.details,
  navigatorKey: rootNavKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavKey1,
          routes: [
            GoRoute(
              path: AppRoutes.mainPage,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: MainPage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKey2,
          routes: [
            GoRoute(
              path: AppRoutes.orderPage,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  // child: UserOrderPage(),
                  child: OrdersPage(),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKey3,
          routes: [
            GoRoute(
              path: AppRoutes.statisticsPage,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    appBar: AppBar(title: Text('statisticsPage'),),
                  ),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKey4,
          routes: [
            GoRoute(
              path: AppRoutes.userPage,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    appBar: AppBar(title: Text('userPage'),),
                  ),
                );
              },
            )
          ],
        ),
      ],
    ),

    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) {
        return SignInPage();
      },
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) {
        return ChangePasswordPage();
      },
    ),
    GoRoute(
      path: AppRoutes.newPassword,
      builder: (context, state) {
        return NewPasswordPage();
      },
    ),
    GoRoute(
      path: AppRoutes.confirmPassword,
      builder: (context, state) {
        return ConfirmPasswordPage();
      },
    ),
    GoRoute(
      path: AppRoutes.details,
      builder: (context, state) {
        return DetailsPage();
      },
    ),
  ],
);
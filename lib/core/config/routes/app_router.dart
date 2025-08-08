import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/config/routes/scaffold_with_nested_nav.dart';
import 'package:crm/core/config/routes/widget_keys_str.dart';
import 'package:crm/features/auth/presentation/pages/change_password_page.dart';
import 'package:crm/features/auth/presentation/pages/confirm_password_page.dart';
import 'package:crm/features/auth/presentation/pages/new_password_page.dart';
import 'package:crm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:crm/features/auth/presentation/pages/sign_up_page.dart';
import 'package:crm/features/clients/client_detail_page.dart';
import 'package:crm/features/clients/clients_page.dart';
import 'package:crm/features/clients/edit_client_page.dart';
import 'package:crm/features/details/presentation/pages/details_page.dart';
import 'package:crm/features/orders/presentation/pages/orders_page.dart';
import 'package:crm/features/projects/presentations/pages/projects_page.dart';
import 'package:crm/features/settings/presentation/pages/profile/edit_profile_page.dart';
import 'package:crm/features/projects/presentations/pages/edit_project_page.dart';
import 'package:crm/features/settings/presentation/pages/profile/profile_page.dart';
import 'package:crm/features/projects/presentations/pages/project_details_page.dart';
import 'package:crm/features/settings/presentation/pages/settings_page.dart';
import 'package:crm/features/settings/presentation/pages/support/support_page.dart';
import 'package:crm/features/settings/presentation/pages/warehouse_page.dart';
import 'package:crm/features/splash/presentation/pages/splash_screen.dart';
import 'package:crm/features/statistics/presentation/pages/statistics_page.dart' show StatisticsPage;
import 'package:crm/features/users/edit_user_profile.dart';
import 'package:crm/features/users/user_page.dart';
import 'package:crm/features/users/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
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
              path: AppRoutes.statistics,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: StatisticsPage());
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
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKey3,
          routes: [
            GoRoute(
              path: AppRoutes.statisticsPage,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(appBar: AppBar(title: Text('Статистика'))),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKey4,
          routes: [
            GoRoute(
              path: AppRoutes.settingsPage,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: SettingsPage());
              },
            ),
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

    // GoRoute(
    //   path: AppRoutes.authGate,
    //   builder: (context, state) {
    //     return AuthGate();
    //   },
    // ),
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
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) {
        return ProfilePage();
      },
    ),
    GoRoute(
      path: AppRoutes.warehouse,
      builder: (context, state) {
        return WareHousePage();
      },
    ),
    GoRoute(
      path: AppRoutes.projects,
      builder: (context, state) {
        return ProjectsPage();
      },
    ),
    GoRoute(
      path: '${AppRoutes.projectDetails}/:id',
      builder: (context, state) {
        final  projectId = state.pathParameters['id']??'';
        final id = int.parse(projectId);
        return ProjectDetailsPage(id: id);
      },
    ),

    GoRoute(
      path: AppRoutes.editProject,
      builder: (context, state) {
        return EditProjectPage();
      },
    ),
    GoRoute(
      path: AppRoutes.contacts,
      builder: (context, state) {
        return ContactsPage();
      },
    ),
    GoRoute(
      path: AppRoutes.contactDetails,
      builder: (context, state) {
        return ContactDetailPage();
      },
    ),
    GoRoute(
      path: AppRoutes.editContact,
      builder: (context, state) {
        return EditContactPage();
      },
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) {
        return EditProfilePage();
      },
    ),
    GoRoute(
      path: AppRoutes.employee,
      builder: (context, state) {
        return EmployeePage();
      },
    ),
    GoRoute(
      path: AppRoutes.employeeProfile,
      builder: (context, state) {
        return EmployeeProfilePage();
      },
    ),
    GoRoute(
      path: AppRoutes.employeeProfileEdit,
      builder: (context, state) {
        return EmployeeProfileEditPage();
      },
    ),
    GoRoute(
      path: AppRoutes.support,
      builder: (context, state) {
        return SupportPage();
      },
    ),
  ],
);

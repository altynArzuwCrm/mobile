import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/config/routes/scaffold_with_nested_nav.dart';
import 'package:crm/core/config/routes/widget_keys_str.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:crm/features/clients/presentation/pages/client_detail_page.dart';
import 'package:crm/features/clients/presentation/pages/clients_page.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/presentation/pages/company_detail_page.dart';
import 'package:crm/features/clients/presentation/pages/edit_client_page.dart';
import 'package:crm/features/clients/presentation/pages/search_client_page.dart';
import 'package:crm/features/notifications/presentation/pages/notification_page.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/pages/add_order_page.dart';
import 'package:crm/features/orders/presentation/pages/edit_order_page.dart';
import 'package:crm/features/orders/presentation/pages/order_details_page.dart';
import 'package:crm/features/orders/presentation/pages/orders_page.dart';
import 'package:crm/features/orders/presentation/pages/search_order_page.dart';
import 'package:crm/features/products/presentation/pages/product_detail_page.dart';
import 'package:crm/features/products/presentation/pages/search_products.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/presentations/pages/projects_page.dart';
import 'package:crm/features/projects/presentations/pages/edit_project_page.dart';
import 'package:crm/features/projects/presentations/pages/project_details_page.dart';
import 'package:crm/features/projects/presentations/pages/search_project_page.dart';
import 'package:crm/features/settings/presentation/pages/settings_page.dart';
import 'package:crm/features/settings/presentation/pages/support/support_page.dart';
import 'package:crm/features/products/presentation/pages/products_page.dart';
import 'package:crm/features/splash/presentation/pages/splash_screen.dart';
import 'package:crm/features/statistics/presentation/pages/activities_page.dart';
import 'package:crm/features/statistics/presentation/pages/statistics_page.dart'
    show StatisticsPage;
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/presentation/pages/components/add_user_page.dart';
import 'package:crm/features/users/presentation/pages/edit_user_page.dart';
import 'package:crm/features/users/presentation/pages/profile/edit_profile_page.dart';
import 'package:crm/features/users/presentation/pages/profile/profile_page.dart';
import 'package:crm/features/users/presentation/pages/search_user_page.dart';
import 'package:crm/features/users/presentation/pages/user_page.dart';
import 'package:crm/features/users/presentation/pages/user_details.dart';
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
              path: AppRoutes.mainStatistics,
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
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) {
        return SignInPage();
      },
    ),
    // GoRoute(
    //   path: AppRoutes.signUp,
    //   builder: (context, state) {
    //     return SignUpPage();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.changePassword,
    //   builder: (context, state) {
    //     return ChangePasswordPage();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.newPassword,
    //   builder: (context, state) {
    //     return NewPasswordPage();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.confirmPassword,
    //   builder: (context, state) {
    //     return ConfirmPasswordPage();
    //   },
    // ),
    GoRoute(
      path: AppRoutes.addUser,
      builder: (context, state) {
        return AddUserPage();
      },
    ),
    GoRoute(
      path: AppRoutes.addOrder,
      builder: (context, state) {
        return AddOrderPage();
      },
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) {
        return NotificationPage();
      },
    ),
    GoRoute(
      path: '${AppRoutes.orderDetails}/:id',
      builder: (context, state) {
        final projectId = state.pathParameters['id'] ?? '';
        final id = int.parse(projectId);
        return OrderDetailsPage(id: id);
      },
    ),
    GoRoute(
      path: '${AppRoutes.companyDetails}/:title',
      builder: (context, state) {
        final title = state.pathParameters['title'] ?? '';
        return CompanyDetailPage(title: title);
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
        return ProductsPage();
      },
    ),
    GoRoute(
      path: AppRoutes.projects,
      builder: (context, state) {
        return ProjectsPage();
      },
    ),
    GoRoute(
      path: AppRoutes.searchClients,
      builder: (context, state) {
        return ClientsSearchPage();
      },
    ),
    GoRoute(
      path: AppRoutes.searchUsers,
      builder: (context, state) {
        return UsersSearchPage();
      },
    ),
    GoRoute(
      path: AppRoutes.searchOrders,
      builder: (context, state) {
        return OrdersSearchPage();
      },
    ),
    GoRoute(
      path: AppRoutes.searchProdcuts,
      builder: (context, state) {
        return ProductsSearchPage();
      },
    ),
    GoRoute(
      path: AppRoutes.searchProjects,
      builder: (context, state) {
        return ProjectsSearchPage();
      },
    ),
    GoRoute(
      path: '${AppRoutes.productDetail}/:id',

      builder: (context, state) {
        final productId = state.pathParameters['id'] ?? '';
        final id = int.parse(productId);
        return ProductDetailPage(id: id);
      },
    ),
    GoRoute(
      path: '${AppRoutes.projectDetails}/:id',
      builder: (context, state) {
        final projectId = state.pathParameters['id'] ?? '';
        final id = int.parse(projectId);
        return ProjectDetailsPage(id: id);
      },
    ),

    GoRoute(
      path: AppRoutes.editProject,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final ProjectEntity project = extra['project'];

          return EditProjectPage(project: project);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.contacts,
      builder: (context, state) {
        return ContactsPage();
      },
    ),

    GoRoute(
      path: AppRoutes.editOrderPage,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final OrderModel order = extra['order'];

          return EditOrderPage(order: order);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.clientDetails,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final ClientEntity client = extra['client'];

          return ClientDetailPage(client: client);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editContact,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final ClientEntity client = extra['client'];

          return EditContactPage(client: client);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final UserEntity user = extra['user'];

          return EditProfilePage(user: user);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.userPage,
      builder: (context, state) {
        return UserPage();
      },
    ),

    GoRoute(
      path: AppRoutes.userDetails,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final UserEntity user = extra['user'];

          return UserDetailsPage(user: user);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.editUserData,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;

          final UserEntity user = extra['user'];

          return EditUserPage(user: user);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(AppStrings.error)),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.support,
      builder: (context, state) {
        return SupportPage();
      },
    ),
    GoRoute(
      path: AppRoutes.activities,
      builder: (context, state) {
        return ActivitiesPage();
      },
    ),
  ],
);

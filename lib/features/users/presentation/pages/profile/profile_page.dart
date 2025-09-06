import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/features/users/presentation/widgets/profile_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.profile),
        actions: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppBarIcon(
                    onTap: () {
                      context.push(
                        AppRoutes.editProfile,
                        extra: {"user": state.data},
                      );
                    },
                    icon: IconAssets.edit,
                    padding: EdgeInsets.all(10),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final data = state.data;
              return Column(
                children: [
                  Expanded(
                    child: UserProfileWidget(
                      name: data.name,
                      jobs:
                          data.roles?.map((e) => e.displayName).toList() ?? [],
                      phone: data.phone,
                    ),
                  ),
                  MainButton(
                    buttonTile: 'Выйти',
                    onPressed: () {
                      _logout(context);
                    },
                    isLoading: false,
                  ),
                ],
              );
            } else if (state is UserConnectionError) {
              return Center(child: Text(AppStrings.noInternet));
            } else {
              return Center(child: Text(AppStrings.error));
            }
          },
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 24,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, // or AppColors.background
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppStrings.confirmExit,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.confirmLogout,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 24),

                // Cancel + Logout buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: MainButton(
                        buttonTile: AppStrings.cancel,
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        isLoading: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MainButton(
                        buttonTile: AppStrings.logout,
                        onPressed: () {
                          locator<AuthBloc>().add(LogOutEvent());
                          context.go(AppRoutes.splash);
                        },
                        isLoading: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
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
                      context.push(AppRoutes.editProfile,extra: {"user": state.data});
                    },
                    icon: IconAssets.edit,
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
              return UserProfileWidget(
                name: data.name,
                jobs: data.roles?.map((e) => e.displayName).toList() ?? [],
                phone: data.phone,
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
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.jobs,
  });

  final String name;
  final String? phone;
  final List<String> jobs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.general,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          ProfileItemWidget(title: AppStrings.name, name: name),
          if(phone != null)
          SizedBox(height: 20),
          if(phone != null)
          ProfileItemWidget(title: AppStrings.number, name: phone??''),
          SizedBox(height: 20),
          Column(
            children: List.generate(
              jobs.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ProfileItemWidget(
                  title: AppStrings.position,
                  name: jobs[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

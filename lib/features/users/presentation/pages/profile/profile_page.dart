import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_card.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppBarIcon(onTap: () {
              context.push(AppRoutes.editProfile);
            }, icon: IconAssets.edit),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is UserLoaded) {
                final data = state.data;
                return UserProfileWidget(
                  name: data.name,
                  surname: data.username,
                  job: data.roles?.first.displayName ?? '',
                  email: '',
                  phone: '',
                  birthday: '',
                );
              } else if (state is UserConnectionError) {
                return Center(child: Text(AppStrings.noInternet));
              } else {
                return Center(child: Text(AppStrings.error));
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.name,
    required this.surname,
    required this.job,
    required this.email,
    required this.phone,
    required this.birthday,
  });

  final String name;
  final String surname;
  final String job;
  final String email;
  final String phone;
  final String birthday;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
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

          SizedBox(height: 2),
          ProfileItemWidget(title: AppStrings.name, name: name),
          SizedBox(height: 20),
          ProfileItemWidget(title: AppStrings.surname, name: surname),
          SizedBox(height: 20),
          ProfileItemWidget(title: AppStrings.position, name: job),
          SizedBox(height: 20),
          ProfileItemWidget(
            title: AppStrings.birthday,
            name: birthday,
            showDate: true,
          ),
          SizedBox(height: 35),
          Text(
            AppStrings.contacts,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 4),
          ProfileItemWidget(title: AppStrings.email, name: email),
          SizedBox(height: 20),
          ProfileItemWidget(title: AppStrings.number, name: phone),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

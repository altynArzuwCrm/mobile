import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/presentation/cubits/user_details/user_details_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key, required this.user});

  final UserEntity user;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final userDetails = locator<UserDetailsCubit>();

  @override
  void initState() {
    super.initState();
    userDetails.getUserDetails(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.aboutUser),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.editUserData,extra: {'user':widget.user});
              },
              icon: IconAssets.edit,
            ),
          ),
        ],
      ),

      body: BlocProvider.value(
        value: userDetails,
        child: BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserDetailsLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                child: UserDetailsWidget(
                  name: data.name,
                  surname: data.username,
                  job: data.roles?.first.displayName,
                  company: '',
                  location: '',
                  email: '',
                  phone: data.phone,
                  birthday: '',
                ),
              );
            } else if (state is UserDetailsConnectionError) {
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

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    super.key,
    required this.name,
    required this.surname,
    required this.job,
    required this.company,
    required this.location,
    required this.email,
    required this.phone,
    required this.birthday,
  });

  final String name;
  final String surname;
  final String? job;
  final String company;
  final String location;
  final String email;
  final String phone;
  final String birthday;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: MainCardWidget(
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
            SizedBox(height: 20),
            ProfileItemWidget(title: AppStrings.surname, name: surname),
            SizedBox(height: 20),
            ProfileItemWidget(title: AppStrings.position, name: job??''),
            SizedBox(height: 20),
            ProfileItemWidget(
              title: AppStrings.company,
              name: company,
              showDate: true,
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.gray,
                size: 20,
              ),
            ),
            SizedBox(height: 20),
            ProfileItemWidget(
              title: AppStrings.location,
              name: location,
              showDate: true,
              child: Icon(
                Icons.location_on_outlined,
                color: AppColors.gray,
                size: 20,
              ),
            ),
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
            SizedBox(height: 15),
            ProfileItemWidget(title: AppStrings.email, name: email),
            SizedBox(height: 20),
            ProfileItemWidget(title: AppStrings.number, name: phone),
            SizedBox(height: 35),
            MainButton(
              buttonTile: AppStrings.back,
              onPressed: () {
                context.pop();
              },
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}

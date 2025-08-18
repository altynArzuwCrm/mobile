
import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/presentation/cubits/user_details/user_details_cubit.dart';
import 'package:crm/features/users/presentation/pages/profile/profile_page.dart' show UserProfileWidget;
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

          BlocBuilder<UserDetailsCubit, UserDetailsState>(
            builder: (context, state) {
              if (state is UserDetailsLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppBarIcon(
                    onTap: () {
                      //todo client
                      context.push(AppRoutes.editUserData,extra: {'user': state.data});
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
        child: BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserDetailsLoaded) {
              final data = state.data;
              return UserProfileWidget(
                name: data.name,
                jobs: data.roles?.map((e) => e.displayName).toList() ?? [],
                phone: data.phone,
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


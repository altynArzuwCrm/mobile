import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/settings/presentation/widgets/settings_widget.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/features/users/presentation/pages/components/user_data_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> titles = [
    AppStrings.profile,
    AppStrings.projects,
    AppStrings.contacts,
    AppStrings.members,
    AppStrings.productSupport,
    AppStrings.support,
  ];

  final List<String> icons = [
    IconAssets.profile,
    IconAssets.project,
    IconAssets.contact,
    IconAssets.members,
    IconAssets.warehouse,
    IconAssets.support,
  ];

  final List<String> routes = [
    AppRoutes.profile,
    AppRoutes.projects,
    AppRoutes.contacts,
    AppRoutes.userPage,
    AppRoutes.warehouse,
    AppRoutes.support,
  ];
  final userCubit = locator<UserCubit>();

  @override
  void initState() {
    super.initState();
    userCubit.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: SvgPicture.asset(IconAssets.mainLogo),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.notifications);
              },
              icon: IconAssets.notifications,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: MainCardWidget(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    final data = state.data;
                    return UserDataWidget(
                      name: data.name,
                      job: data.username,
                      image: data.image,
                    );
                  }

                  return UserDataWidget(name: null, job: null, image: null);
                },
              ),
              Divider(color: AppColors.commentTimeBorder, thickness: 1),

              SettingsWidget(titles: titles, icons: icons, routes: routes),
            ],
          ),
        ),
      ),
    );
  }
}

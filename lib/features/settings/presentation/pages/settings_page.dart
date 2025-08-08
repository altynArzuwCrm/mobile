import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/settings/presentation/widgets/settings_widget.dart';
import 'package:crm/features/settings/presentation/widgets/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

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
    AppRoutes.employee,
    AppRoutes.warehouse,
    AppRoutes.support,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: SvgPicture.asset(IconAssets.mainLogo),
        ),

        actions: [
          AppBarIcon(onTap: () {}, icon: IconAssets.search),
          SizedBox(width: 7),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(onTap: () {}, icon: IconAssets.notifications),
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
              UserDataWidget(),
              Divider(color: AppColors.commentTimeBorder, thickness: 1),

              SettingsWidget(titles: titles, icons: icons, routes: routes),
            ],
          ),
        ),
      ),
    );
  }
}

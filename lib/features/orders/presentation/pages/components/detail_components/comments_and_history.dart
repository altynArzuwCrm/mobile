import 'package:crm/common/widgets/custom_tabbar.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

class CommentsAndHistory extends StatelessWidget {
  const CommentsAndHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomTabBar(
      onTap: (index) {
        // DefaultTabController.of(context).animateTo(index);
      },
      isScrollable: false,
      indicatorPadding: EdgeInsets.zero,
      selectedLabelColor: AppColors.primary,
      unSelectedLabelColor:AppColors.primary,
      tabs: [
        Tab(
          text: AppStrings.comments,
        ),
        Tab(
          text: AppStrings.history,
        ),
      ],

    );
  }
}


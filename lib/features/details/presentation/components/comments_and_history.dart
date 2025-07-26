import 'package:crm/common/widgets/custom_tabbar.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CommentsAndHistory extends StatelessWidget {
  const CommentsAndHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: CustomTabBar(
        onTap: (index) {},
        isScrollable: false,
        indicatorPadding: EdgeInsets.zero,
        selectedLabelColor: AppColors.primary,
        unSelectedLabelColor:
        Theme.of(context).textTheme.bodyLarge!.color!,
        tabs: [
          Tab(
            text: 'allResults',
          ),
          Tab(
            text: 'book',
          ),
        ],

      ),
    );
  }
}


import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TabBarHeader extends StatelessWidget {
  const TabBarHeader({
    super.key,
    required this.tabController,
    required this.tabs, this.margin, this.tabBarColor,
  });

  final TabController tabController;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? margin;
  final Color? tabBarColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 49.0,
          margin:margin ?? const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color:tabBarColor ?? AppColors.tabBarColor,
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        TabBar(
          padding: margin?? const EdgeInsets.symmetric(horizontal: 10),
          labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          unselectedLabelColor: AppColors.darkBlue,
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),

          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: AppColors.sendBtn,
          ),

          controller: tabController,
          tabs: tabs,
        ),
      ],
    );
  }
}

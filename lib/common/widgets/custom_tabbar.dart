import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.indicatorPadding,
    required this.isScrollable,
    required this.selectedLabelColor,
    required this.unSelectedLabelColor,
    this.onTap,
    this.labelPadding,
  });

  final List<Widget> tabs;
  final bool isScrollable;
  final EdgeInsetsGeometry indicatorPadding;
  final Color selectedLabelColor;
  final Color unSelectedLabelColor;
  final ValueChanged<int>? onTap;
  final EdgeInsetsGeometry? labelPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightBlue,
      child: TabBar(
          onTap: onTap,
          isScrollable: isScrollable,
          padding: const EdgeInsets.only(top: 10),

          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3.0,
            ),

          ),
          splashFactory: NoSplash.splashFactory,
          overlayColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            return states.contains(WidgetState.focused)
                ? null
                : Colors.transparent;
          }),
          labelPadding:labelPadding ?? const EdgeInsets.only(left: 10, right: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: unSelectedLabelColor,
          unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: TextFonts.nunito,
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: TextFonts.nunito,
            overflow: TextOverflow.visible,
          ),
          labelColor: selectedLabelColor,
          indicatorPadding: indicatorPadding,
          tabs: tabs),
    );
  }
}
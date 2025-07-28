import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainCardWidget extends StatelessWidget {
  const MainCardWidget({super.key, required this.child, this.padding});

  final Widget child;
final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 18,vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: child,
    );
  }
}

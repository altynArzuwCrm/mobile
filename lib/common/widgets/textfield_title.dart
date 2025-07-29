import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.title,
    required this.child,
    this.bottomHeight, this.padding,
  });

  final String title;
  final Widget child;
  final double? bottomHeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.only(left: 6.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.gray,
            ),
          ),
        ),
        SizedBox(height: bottomHeight ?? 7),
        child,
      ],
    );
  }
}

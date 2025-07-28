import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon, width: 22, height: 22, fit: BoxFit.cover),
            SizedBox(width: 18),
            Text(
              title,
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios_outlined, size: 16),
      ],
    );
  }
}

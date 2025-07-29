import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.title,
    required this.name,
    this.showDate = false,
    this.child,
  });

  final String title;
  final String name;
  final bool showDate;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.gray,
            ),
          ),
        ),
        SizedBox(height: 7),
        Stack(
          children: [
            Container(
              width: double.infinity,

              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.timeBorder),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.gray,
                ),
              ),
            ),
            if (showDate)
              Positioned(
                right: 18,
                top: 13,
                bottom: 13,
                child:
                    child ??
                    SvgPicture.asset(
                      IconAssets.calendar,
                      width: 24,
                      height: 24,
                    ),
              ),
          ],
        ),
      ],
    );
  }
}

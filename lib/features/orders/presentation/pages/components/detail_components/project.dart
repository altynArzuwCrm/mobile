import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:flutter/material.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key, required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.project,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.normalGray,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            AppStrings.description,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 12),
          Text(
            AppStrings.lorem,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}

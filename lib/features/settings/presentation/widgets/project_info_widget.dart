import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectInfoWidget extends StatelessWidget {
  const ProjectInfoWidget({
    super.key,
    required this.deadline,
    required this.started,
    required this.sum,
    required this.client,
  });

  final String? deadline;
  final String? started;
  final String? sum;
  final String? client;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allInfo,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          Text(
            AppStrings.client,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          if (client != null)
            Text(
              client!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.darkBlue,
              ),
            ),
          if (client != null) SizedBox(height: 22),
          Text(
            AppStrings.dedline,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          if (deadline != null)
            Text(
              deadline!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.darkBlue,
              ),
            ),
          SizedBox(height: 22),
          Text(
            AppStrings.sum,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$sum тмт',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SvgPicture.asset(
                IconAssets.calendar,
                width: 22,
                height: 20,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 24),
              if (started != null)
                Text(
                  'Created\t$started',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.gray,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

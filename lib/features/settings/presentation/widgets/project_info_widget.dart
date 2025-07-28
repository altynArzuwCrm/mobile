import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/details/presentation/widgets/person_img_with_title_widget.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectInfoWidget extends StatelessWidget {
  const ProjectInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Общая инфмормация',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Заказчик',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Evan Yates',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 22),
          Text(
            'Дедлайн',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Feb 23, 2020',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 22),
          Text(
            'Сумма',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '2500тмт',
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
              Text(
                'Created May 28, 2020',
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

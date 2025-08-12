import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/person_img_with_title_widget.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key, required this.name, required this.deadline, required this.price, required this.createdTime});

  final String? name;
  final String? deadline;
  final String? price;
  final String? createdTime;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.allInfo,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.darkBlue,
                ),
              ),

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.bgColor,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_up),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
            ],
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
          PersonImgWithTitleWidget(image: img, name: name??''),

          SizedBox(height: 22),
          Text(
            AppStrings.responsible,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          PersonImgWithTitleWidget(image: img, name: 'Black Sliva'),
          SizedBox(height: 22),
          Text(
            AppStrings.dedline,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.normalGray,
            ),
          ),
          SizedBox(height: 8),
          Text(
           deadline??'',
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
            '$price тмт',
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
                createdTime??'',
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

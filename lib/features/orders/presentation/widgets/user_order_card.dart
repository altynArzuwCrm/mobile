import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

var img =
    'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg';

class UserOrderCard extends StatelessWidget {
  const UserOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 20, right: 25, left: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.white,
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Наименование заказа',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Название заказа',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(color: AppColors.blue, width: 2),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2d 4h',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    AppStrings.responsible,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ImageWithShimmer(
                      height: 24,
                      width: 24,
                      imageUrl: img,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    AppStrings.dedline,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 2),

                  Text(
                    '1d 2h',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppStrings.acceptJob,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.green,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.moreDetails,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

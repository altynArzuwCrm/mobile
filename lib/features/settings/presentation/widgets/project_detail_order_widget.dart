import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart'
    show MainCardWidget;
import 'package:flutter/material.dart';

class ProjectDetailOrderWidget extends StatelessWidget {
  const ProjectDetailOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainCardWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.coverDesign,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkBlue,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    AppStrings.responsible,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '2d 4h',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined, size: 16),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 15,
          bottom: 15,
          child: Container(
            width: 4,
            // height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.sendBtn,
            ),
          ),
        ),
      ],
    );
  }
}

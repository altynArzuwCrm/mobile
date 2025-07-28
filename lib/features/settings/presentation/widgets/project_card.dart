import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainCardWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PN0001245',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkBlue,
                ),
              ),

              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Начало',
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
                        'Ответственный',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.normalGray,
                        ),
                      ),
                      SizedBox(height: 2),

                      Text(
                        'Марал Маралова',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Дедлайн',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(Icons.arrow_forward_ios_outlined,size: 16,),
                  )

                ],
              ),
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

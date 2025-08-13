import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailOrderWidget extends StatelessWidget {
  const ProjectDetailOrderWidget({
    super.key,
    required this.title,
    required this.client,
    required this.deadline,
    required this.id,
  });

  final String title;
  final String client;
  final String deadline;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (id != null) {
              context.push('${AppRoutes.orderDetails}/$id');

          }
          },
          child: MainCardWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkBlue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 5),

                      Text(
                        client,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.normalGray,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        deadline,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios_outlined, size: 16),
              ],
            ),
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

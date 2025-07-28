import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/person_img_with_title_widget.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PersonImgWithTitleWidget(image: img, name: 'Olivie Dixon'),
            SizedBox(width: 6),
            Text(
              '12:04 AM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.commentTimeBorder),
          ),
          child: Text(
            'Смена ответственного Maral maralowa на Gurban Gurbanow',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
            ),
          ),
        ),
        Divider(thickness: 1, color: AppColors.commentTimeBorder),
      ],
    );
  }
}

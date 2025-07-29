import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/person_img_with_title_widget.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.showTime});

  final bool showTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PersonImgWithTitleWidget(image: img, name: 'Olivie Dixon'),
            SizedBox(width: 6),
            Text('12:04 AM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6,left: 40),
          child: Text(
            'Hi, Evan! Nice to meet you too I will send you all the files I have for this project. After that, we can call and discuss. I will answer all your questions! OK?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        if(showTime)
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.commentTimeBorder),
          ),
          child: Text('Friday, September 8',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
        ),
        if(showTime)
        Divider(thickness: 1,color: AppColors.commentTimeBorder,)
      ],
    );
  }
}

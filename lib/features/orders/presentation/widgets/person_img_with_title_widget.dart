import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class PersonImgWithTitleWidget extends StatelessWidget {
  const PersonImgWithTitleWidget({super.key,required this.image, required this.name,  this.textStyle});

  final String image;
  final String name;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: ImageWithShimmer(height: 24, width: 24, imageUrl: image),
        ),
        SizedBox(width: 14),

        Text(
          name,
          style:textStyle ?? TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

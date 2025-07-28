import 'package:crm/common/widgets/shimmer_image.dart' show ImageWithShimmer;
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ImageWithShimmer(imageUrl: img, width: 60, height: 60),
          ),
          SizedBox(height: 16),
          Text(
            'Марина Амановна',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Дизайнер',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

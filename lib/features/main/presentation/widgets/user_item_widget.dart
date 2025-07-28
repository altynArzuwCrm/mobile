import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 35, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ImageWithShimmer(imageUrl: img, width: 53, height: 53),
          ),
          const SizedBox(width: 20),
      
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Updated the status of Mind Map task to In Progress',
      
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 9),
                Text(
                  '6h ago',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.gray,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

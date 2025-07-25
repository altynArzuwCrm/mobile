import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

class SearchChip extends StatelessWidget {
  const SearchChip({super.key, required this.title, required this.onTap, required this.onDeleted});

  final String title;
  final VoidCallback onTap;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(onDeleted: onDeleted,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.bgColor,
        deleteIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.cancel, color: AppColors.gray),
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ImageWithShimmer(height: 24, width: 24, imageUrl: img),
            ),
            SizedBox(width: 8),

            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.accent,
              ),
            ),

            // SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
    required this.title,
    required this.text,
    required this.time, required this.orderId,
  });

  final String title;
  final String text;
  final String time;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('${AppRoutes.orderDetails}/$orderId');

      },
      child: Padding(
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
                    title,

                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    text,

                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    time,
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
      ),
    );
  }
}

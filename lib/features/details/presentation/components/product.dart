import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Товары',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 20),
        ProductItemWidget()
      ],
    );
  }
}

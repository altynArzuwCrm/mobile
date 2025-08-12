import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.products,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 20),
        ProductItemWidget(title: title),
      ],
    );
  }
}

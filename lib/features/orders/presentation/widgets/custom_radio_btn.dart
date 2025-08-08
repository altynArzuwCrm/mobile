import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;

  const CustomRadioButton({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.blue, width: 2),
      ),
      child: Center(
        child: isSelected
            ? Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}

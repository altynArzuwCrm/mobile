import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        backgroundColor: isSelected ? AppColors.chipBg :AppColors.lightGray,

        label:  Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 11,
          color: isSelected ? AppColors.red : AppColors.darkGray,
        ),
      ),),
    );
  }
}

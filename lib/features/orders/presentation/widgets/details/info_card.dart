import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable info row
class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.normalGray,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}

/// Reusable info block (title + value stacked)
class InfoBlock extends StatelessWidget {
  final String title;
  final String value;

  const InfoBlock({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.normalGray,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}

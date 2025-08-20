import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddProductBtn extends StatelessWidget {
  const AddProductBtn({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Товары',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),

          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.bgColor,
            ),
            child: IconButton(onPressed: onTap, icon: Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
}

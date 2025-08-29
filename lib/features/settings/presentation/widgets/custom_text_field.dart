import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  const CustomTextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.isPhone = false, this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final bool isPhone;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.gray,
          ),
        ),

        SizedBox(height: 7),
        isPhone
            ? PhoneNumField(phoneCtrl: controller, isSubmitted: false,hint: hintText,)
            : KTextField(
                controller: controller,
                isSubmitted: false,
                hintText: hintText,
                suffixIcon: suffixIcon,
          keyboardType: keyboardType,
              ),
      ],
    );
  }
}

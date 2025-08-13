import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final List<DropdownMenuItem<String>> items;
  final String? hintText;
  final Widget? icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.hintText,
    this.icon,
    this.borderColor,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor = borderColor ?? AppColors.timeBorder;
    final Color effectiveBackground = backgroundColor ?? AppColors.white;

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        height: 50,
        decoration: BoxDecoration(
          color: effectiveBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: effectiveBorderColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            icon:
                icon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.gray,
                  size: 22,
                ),
            elevation: 8,
            value: value,
            hint: hintText != null
                ? Text(hintText!, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.gray,
            ),
            )
                : null,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

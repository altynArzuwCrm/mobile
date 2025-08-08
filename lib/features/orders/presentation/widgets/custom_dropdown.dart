import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final List<DropdownMenuItem<String>> items;
  final String? hintText;
  final TextStyle? style;
  final Color? color;
  final Color? iconColor;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.hintText, this.style, this.color, this.iconColor, this.padding, this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding:padding ?? const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:color ?? AppColors.lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            borderRadius: BorderRadius.circular(5),
            hint: hintText != null
                ? Text(
                    hintText!,
                    style: style ?? TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.blue,
                    ),
                  )
                : null,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color:iconColor?? AppColors.primary,
            ),
            elevation: 5,
            items: items,
            onChanged: onChanged,
            dropdownColor: bgColor ?? Color(0xff6FADFF),
             style: style,
          ),
        ),
      ),
    );
  }
}

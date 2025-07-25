import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonTile,
    this.height,
    required this.onPressed,
    this.isDisable,
    this.hasIcon,
    this.btnColor,
    this.elevation,
    required this.isLoading,
  });

  final bool? isDisable;
  final String buttonTile;
  final double? height;
  final bool? hasIcon;
  final Color? btnColor;
  final double? elevation;
  final bool isLoading;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(elevation),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisable == true) {
              return Theme.of(context).disabledColor;
            }
            return btnColor ?? AppColors.primary;
          }),
        ),
        onPressed: isDisable == true ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 23,
                width: 23,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonTile,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (hasIcon != null)
                    Icon(Icons.arrow_forward_sharp, color: AppColors.white),
                ],
              ),
      ),
    );
  }
}

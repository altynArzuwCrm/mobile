import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.bgColor,
    required this.child,
    this.width,
    this.height,
  });

  final Color? bgColor;
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      elevation: 4,
      insetPadding: EdgeInsets.symmetric(horizontal: 35),
      shadowColor: Theme.of(context).shadowColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: child,
      ),
    );
  }

}
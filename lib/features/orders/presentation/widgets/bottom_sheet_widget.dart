
import 'package:flutter/material.dart';

bottomSheetWidget({
  required BuildContext context,
  required bool isScrollControlled,
  required Widget child,
  Color? color,
}) {
  showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: isScrollControlled,
      context: context,
      backgroundColor: color ?? Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => child);
}
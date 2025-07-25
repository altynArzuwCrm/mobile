import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconHeight,
    this.iconWidth,
    this.color,
  });

  final String icon;
  final void Function() onTap;
  final double? iconHeight;
  final double? iconWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SvgPicture.asset(
          icon,
          height: iconHeight ?? 24,
          width: iconWidth ?? 24,
          color: color ??  Theme.of(context).appBarTheme.iconTheme!.color,
        ),
      ),
    );
  }
}
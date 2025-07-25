import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      gradient: LinearGradient(colors: [Color(0xff005BFF), Color(0xff5F98FF)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(IconAssets.logo, width: 50, height: 27),
          Text(
            'Worky',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              fontFamily: TextFonts.museo,
              color: AppColors.white,
            ),
          ),
          Text(
            'Digital & IT',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              fontFamily: TextFonts.gilroy,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

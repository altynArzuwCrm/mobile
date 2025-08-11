import 'dart:async';

import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  // final _appPreferences = locator<AppPreferences>();

  _startDelay() async {
    _timer = Timer(const Duration(milliseconds: 3000), _goNext);
  }

  void _goNext() async {
    final isRegistered = locator<AuthBloc>().state;

    if (!mounted) return;

    //context.go(AppRoutes.mainPage);

    if (isRegistered is Authenticated) {
      context.go(AppRoutes.mainStatistics);
    } else {
      context.go(AppRoutes.signIn);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
            AppStrings.splashName,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              fontFamily: TextFonts.museo,
              color: AppColors.white,
            ),
          ),
          Text(
            AppStrings.digital,
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

import 'dart:async';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() async {
    _timer = Timer(const Duration(milliseconds: 3000), _goNext);
  }

  void _goNext() async {
    final isRegistered = locator<AuthBloc>().state;

    if (!mounted) return;

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
    return Scaffold(
      backgroundColor: Color(0xff6392E5),
      body: BgColorWidget(
        child:  Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: SvgPicture.asset(
              ImageAssets.splashLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

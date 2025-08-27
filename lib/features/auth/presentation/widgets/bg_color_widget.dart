import 'package:flutter/material.dart';

class BgColorWidget extends StatelessWidget {
  const BgColorWidget({super.key, required this.child, this.gradient, this.width, this.height});

  final Widget child;
  final Gradient? gradient;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xff6392E5),
      body: Container(
        width:width ?? double.infinity,
        height: height?? double.infinity,
        decoration: BoxDecoration(
            gradient: gradient ?? LinearGradient(colors: [
              Color(0xff5F98FF),
              Color(0xff6392E5),
              Color(0xff4778D1),
              Color(0xff3C95FD),
            ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: child,
      ),
    );
  }
}

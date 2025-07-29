import 'package:flutter/material.dart';

class BgColorWidget extends StatelessWidget {
  const BgColorWidget({super.key, required this.child, this.gradient});

  final Widget child;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xff6392E5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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

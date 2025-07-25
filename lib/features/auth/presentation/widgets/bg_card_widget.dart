import 'package:flutter/material.dart';

class BgCardWidget extends StatelessWidget {
  const BgCardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(250, 250, 250, 0.15),
      ),
      child: child,
    );
  }
}

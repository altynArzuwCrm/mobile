import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      shadowColor: Color.fromRGBO(13, 10, 44, 0.08),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}

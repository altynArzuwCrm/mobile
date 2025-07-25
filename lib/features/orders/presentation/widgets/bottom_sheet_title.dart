import 'package:flutter/material.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key, required this.title, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
              color:
              color ?? Theme.of(context).appBarTheme.titleTextStyle!.color),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: color ?? Theme.of(context).iconTheme.color,
            ))
      ],
    );
  }
}

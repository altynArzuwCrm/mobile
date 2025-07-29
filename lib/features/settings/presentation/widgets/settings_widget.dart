import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'setting_item_widget.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.titles,
    required this.icons,
    required this.routes,
  });

  final List<String> titles;
  final List<String> icons;
  final List<String> routes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          6,
          (index) => InkWell(
            onTap: () {
              context.push(routes[index]);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SettingsItemWidget(
                icon: icons[index],
                title: titles[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

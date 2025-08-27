import 'package:crm/core/config/routes/widget_keys_str.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav_bar_widget.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  List<String> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = [
      IconAssets.mainBottom,
      IconAssets.orderBottom,
      IconAssets.userBottom,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: buildBottomWidget(),
        ),
      ),
    );
  }

  Widget buildBottomWidget() {
    return BottomNavBar(
      key: bottomNavBarKey,
      onTap: _goBranch,
      currentIndex: widget.navigationShell.currentIndex,
      items: items,
    );
  }
}

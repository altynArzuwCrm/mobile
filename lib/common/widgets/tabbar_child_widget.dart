import 'package:flutter/material.dart';

class TabChildWidget extends StatelessWidget {
  const TabChildWidget({
    super.key,
    required this.childKey,
    required this.delegate,
  });

  final String childKey;
  final Widget delegate;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey<String>(childKey),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            delegate,
          ],
        );
      },
    );
  }
}
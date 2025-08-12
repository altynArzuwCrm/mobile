import 'package:crm/features/orders/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 5, (
          BuildContext context,
          int index,
          ) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 8, 0),
          child: HistoryCard(),
        );
      }),
    );
  }
}

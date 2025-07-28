import 'package:crm/features/details/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 5, (
          BuildContext context,
          int index,
          ) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 8, 0),
          child: CommentCard(showTime: index == 0,),
        );
      }),
    );
  }
}

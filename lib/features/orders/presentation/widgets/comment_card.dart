import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.showTime,
    required this.model,
    required this.onDelete,
  });

  final bool showTime;
  final CommentModel model;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.username,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                SizedBox(width: 6),
                Text(
                  model.time,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    AppStrings.delete,
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            model.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        if (showTime)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.commentTimeBorder),
            ),
            child: Text(
              model.createdAt,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gray,
              ),
            ),
          ),
        if (showTime) Divider(thickness: 1, color: AppColors.commentTimeBorder),
      ],
    );
  }
}

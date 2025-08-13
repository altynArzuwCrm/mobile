import 'dart:io';

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsAppbar extends StatelessWidget {
  const DetailsAppbar({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
              ),
            ),
            SizedBox(width: 15),
            Text(
              AppStrings.orderDetail,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: AppBarIcon(
            icon: IconAssets.edit,
            onTap: () {
              context.push(AppRoutes.editOrderPage, extra: {"order": order});
            },
          ),
        ),
      ],
    );
  }
}

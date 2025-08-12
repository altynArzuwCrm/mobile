import 'dart:io';

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsAppbar extends StatelessWidget {
  const DetailsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
        ),
        Text(
          AppStrings.orderDetail,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBlue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: AppBarIcon(icon: IconAssets.edit, onTap: () {}),
        ),
      ],
    );
  }
}

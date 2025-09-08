import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key, required this.name, required this.job});

  final String? name;
  final String? job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              shape: BoxShape.circle
            ),

            child: Text(name?.substring(0, 1) ?? '',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 5),
          Text(
          name ??  '',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
          job ??  '',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

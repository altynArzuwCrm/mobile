import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart' show ProfileItemWidget;
import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.jobs,
  });

  final String name;
  final String? phone;
  final List<String> jobs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.general,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          ProfileItemWidget(title: AppStrings.name, name: name),
          if (phone != null) SizedBox(height: 20),
          if (phone != null)
            ProfileItemWidget(title: AppStrings.number, name: phone ?? ''),
          SizedBox(height: 20),
          Column(
            children: List.generate(
              jobs.length,
                  (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ProfileItemWidget(
                  title: AppStrings.position,
                  name: jobs[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

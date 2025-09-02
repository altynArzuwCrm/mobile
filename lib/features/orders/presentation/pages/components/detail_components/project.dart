import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:flutter/material.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key, required this.title, required this.contacts});

  final String? title;
  final List<ContactModel> contacts;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title??'',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 10),
          ...contacts.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  Text(
                    '${e.type}:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.normalGray,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    e.value,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

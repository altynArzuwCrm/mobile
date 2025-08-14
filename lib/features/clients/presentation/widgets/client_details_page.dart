import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';

class ClientDetailsWidget extends StatelessWidget {
  const ClientDetailsWidget({
    super.key,
    required this.name,
    required this.company,
    required this.contacts,
  });

  final String name;
  final String company;
  final List<ContactEntity> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
          SizedBox(height: 20),
          ProfileItemWidget(title: AppStrings.company, name: company),
          SizedBox(height: 20),
          ...List.generate(contacts.length, (index) {
            final contact = contacts[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ProfileItemWidget(
                title: contact.type ,
                name: contact.value ,
              ),
            );
          }),
        ],
      ),
    );
  }
}

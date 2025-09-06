
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ContactField {
  final String type;
  final TextEditingController controller;

  ContactField({required this.type, required this.controller});
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.contactField});

  final ContactField contactField;

  @override
  Widget build(BuildContext context) {
    final String displayTitle =
        AppStrings.contactTypesMap[contactField.type] ?? contactField.type;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithTitle(
          controller: contactField.controller,
          title: displayTitle,
          hintText: '',
          isPhone:
          contactField.type == 'phone' || contactField.type == 'whatsapp',
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
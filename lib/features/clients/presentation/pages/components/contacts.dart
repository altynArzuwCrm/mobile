import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/features/settings/presentation/widgets/contacts_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
      itemBuilder: (context, index) {
        return ContactsCard(
          onTap: () {
            context.push(AppRoutes.contactDetails);
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}

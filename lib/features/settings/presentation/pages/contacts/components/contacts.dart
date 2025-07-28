import 'package:crm/common/widgets/main_btn.dart' show MainButton;
import 'package:crm/features/settings/presentation/widgets/contacts_card.dart';
import 'package:crm/features/settings/presentation/widgets/project_card.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
      itemBuilder: (context, index) {
        return ContactsCard();
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}


import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/features/settings/presentation/widgets/contacts_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
      itemBuilder: (context, index) {
        return ContactsCard(
          onTap: () {
            context.push(AppRoutes.employeeProfile);
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}

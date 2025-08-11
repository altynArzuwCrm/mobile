import 'package:crm/features/settings/presentation/widgets/employee_activity_card.dart';
import 'package:flutter/material.dart';

class UserActivityList extends StatelessWidget {
  const UserActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
      itemBuilder: (context, index) {
        return EmployeeActivityCard();
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}


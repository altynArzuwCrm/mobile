import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/custom_dropdown.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:crm/features/statistics/presentation/widgets/chart3.dart';
import 'package:flutter/material.dart';


class Item3 extends StatefulWidget {
  const Item3({super.key});

  @override
  State<Item3> createState() => _Item3State();
}

class _Item3State extends State<Item3> {

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Эффективность сотрудников',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
              CustomDropdown(
                value: selectedCategory,
                padding: EdgeInsets.zero,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
                hintText: 'Месяц',
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                  });
                },
                color: Colors.transparent,
                iconColor: AppColors.gray,
                bgColor: AppColors.bgColor,
                items: const [
                  DropdownMenuItem(value: 'a', child: Text("Week")),
                  DropdownMenuItem(value: 'l', child: Text("Month")),
                  DropdownMenuItem(value: 'm', child: Text("Year")),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.divider, thickness: 1),
          StatsBarChart()
        ],
      ),
    );
  }
}

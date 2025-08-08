import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/statistics/presentation/widgets/chart2.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../orders/presentation/widgets/custom_dropdown.dart';

class Item2 extends StatefulWidget {
  const Item2({super.key});

  @override
  State<Item2> createState() => _Item2State();
}

class _Item2State extends State<Item2> {
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
                'Заказы по стадиям',
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
                hintText: 'Первое полугодие',
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
          SizedBox(height: 10),
          Divider(color: AppColors.divider, thickness: 1),
          BarChartSample2(),
        ],
      ),
    );
  }
}

import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/time.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:crm/features/statistics/presentation/widgets/chart1.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Item1 extends StatelessWidget {
  const Item1({super.key});

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
                'Выручка',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
              Text(
                '2025',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '15502 TMT',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 10),
          Divider(color: AppColors.divider, thickness: 1),
          LineChartSample2(
            data: const [
              FlSpot(0, 0.5),
              FlSpot(1, 3),
              FlSpot(2, 2),
              FlSpot(3, 4),
            ],
            maxX: 7,
            maxY: 4,
            //income.length.toDouble(),
            bottomTitles: months,
            leftTitles: income,
          ),
        ],
      ),
    );
  }
}

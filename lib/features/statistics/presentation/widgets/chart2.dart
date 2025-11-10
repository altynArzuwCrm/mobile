import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatelessWidget {
  final Map<String, int> ordersByStage;

  const BarChartSample2({super.key, required this.ordersByStage});

  @override
  Widget build(BuildContext context) {

    final bottomTitles = ordersByStage.keys.toList();
    final maxY = ordersByStage.values.isNotEmpty
        ? ordersByStage.values.reduce((a, b) => a > b ? a : b).toDouble()
        : 100;

    final barGroups = List.generate(bottomTitles.length, (index) {
      final value = ordersByStage[bottomTitles[index]] ?? 0;
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: value.toDouble(),
            width: 10,
            borderRadius: BorderRadius.circular(100),
            color: AppColors.green,
          ),
        ],
      );
    });

    return AspectRatio(
      aspectRatio: 1.2,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: BarChart(
          BarChartData(
            maxY: maxY * 1.2,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() < 0 || value.toInt() >= bottomTitles.length) return Container();
                    return SideTitleWidget(
                      space: 16,
                      meta: meta,
                      child:
                      // Transform.rotate(
                      //   angle: -0.6, // rotate ~ -35 degrees
                      //   alignment: Alignment.topRight,
                      //   child: Text(
                      //     bottomTitles[value.toInt()],
                      //     style: const TextStyle(
                      //       color: Color(0xff838383),
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 10,
                      //     ),
                      //   ),
                      // ),
                      Text(
                        bottomTitles[value.toInt()],
                        style: const TextStyle(
                          color: Color(0xff838383),
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                  reservedSize: 32,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: maxY / 4,
                  getTitlesWidget: (value, meta) {
                    String text;
                    if (value >= 1000000) {
                      text = '${(value / 1000000).toStringAsFixed(1)}m';
                    } else if (value >= 1000) {
                      text = '${(value ~/ 1000)}k';
                    } else {
                      text = value.toInt().toString();
                    }
                    return SideTitleWidget(space: 10, meta: meta, child: Text(text, style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 10)));
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: barGroups,
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }
}




import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/statistics/presentation/cubits/revenue/revenue_stat_cubit.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:crm/features/statistics/presentation/widgets/chart1.dart';
import 'package:crm/locator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item1 extends StatefulWidget {
  const Item1({super.key});

  @override
  State<Item1> createState() => _Item1State();
}

class _Item1State extends State<Item1> {
  late List<int> availableYears;

  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    availableYears = List.generate(7, (i) => currentYear - 3 + i);
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: BlocBuilder<RevenueStatCubit, RevenueStatState>(
        builder: (context, state) {
          if (state is RevenueStatLoaded) {
            final data = state.data;

            final months = data.monthlyData.map((m) => m.monthName).toList();

            final spots = data.monthlyData.asMap().entries.map((entry) {
              final index = entry.key.toDouble();
              final revenue = entry.value.revenue.toDouble();
              return FlSpot(index, revenue);
            }).toList();

            // find max revenue for scaling
            final maxRevenue = data.monthlyData
                .map((m) => m.revenue.toDouble())
                .reduce((a, b) => a > b ? a : b);

            final year = int.tryParse(data.year);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
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
                    DropdownButton<int>(
                      value: year,
                      borderRadius: BorderRadius.circular(5),

                      items: availableYears
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text(
                                year.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          locator<RevenueStatCubit>().getRevenue(value);
                        }
                      },
                      underline: const SizedBox(),
                      // remove underline if desired
                      icon: const Icon(Icons.arrow_drop_down, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${data.totalRevenueFormatted} TMT',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: AppColors.divider, thickness: 1),

                LineChartSample2(
                  data: spots,
                  maxX: (months.length - 1).toDouble(),
                  maxY: maxRevenue,
                  bottomTitles: months,
                ),
              ],
            );
          } else if (state is RevenueStatLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(AppStrings.error));
          }
        },
      ),
    );
  }
}

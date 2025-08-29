import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/statistics/presentation/cubits/order_stat/order_stat_cubit.dart';
import 'package:crm/features/statistics/presentation/widgets/chart2.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Item2 extends StatelessWidget {
  const Item2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderStatCubit, OrderStatState>(
      builder: (context, state) {
        Map<String, int> ordersByStageData = {};

        if (state is OrderStatLoaded) {
          ordersByStageData = state.data.ordersByStage.ordersByStage;
        }

        return CardWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                AppStrings.orderToStage,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: AppColors.divider, thickness: 1),
              BarChartSample2(ordersByStage: ordersByStageData),
            ],
          ),
        );
      },
    );
  }
}

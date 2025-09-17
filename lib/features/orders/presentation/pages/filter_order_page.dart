import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/sort_order_button.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FilterOrderWidget extends StatefulWidget {
  const FilterOrderWidget({
    super.key,
    required this.selectedStatus,
    required this.initialSortOrder,
    required this.orderBy,
  });

  final String? selectedStatus;
  final String? orderBy;
  final String initialSortOrder;

  @override
  State<FilterOrderWidget> createState() => _FilterOrderWidgetState();
}

class _FilterOrderWidgetState extends State<FilterOrderWidget> {
  late String sortOrder;
  late String? selectedOrderBy;

  final ordersCubit = locator<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    sortOrder = widget.initialSortOrder;
    selectedOrderBy = widget.orderBy;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.filter),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: [
                CategoryBtn(
                  title: "По название",
                  isSelected: selectedOrderBy == 'name',
                  onTap: () {
                    setState(() {
                      selectedOrderBy = 'name';
                    });
                  },
                ),
                CategoryBtn(
                  title: "По времени",
                  isSelected: selectedOrderBy == 'created_at',
                  onTap: () {
                    setState(() {
                      selectedOrderBy = 'created_at';
                    });
                  },
                ),
                CategoryBtn(
                  title: "По дедлайну",
                  isSelected: selectedOrderBy == 'deadline',
                  onTap: () {
                    setState(() {
                      selectedOrderBy = 'deadline';
                    });
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SortOrderSelector(
              sortOrder: sortOrder,
              onChanged: (val) {
                setState(() => sortOrder = val);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 16),
            child: Text(
              'Этапы',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.gray,
              ),
            ),
          ),
          BlocBuilder<StageCubit, StageState>(
            builder: (context, state) {
              if (state is StageLoaded) {
                final data = state.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      CategoryBtn(
                        title: "Все",
                        isSelected: ordersCubit.isStageSelected == 0,
                        onTap: () {
                          setState(() {});
                          ordersCubit.setStage(index: 0, stage: null);
                        },
                      ),
                      ...data.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return CategoryBtn(
                          title: item.displayName,
                          isSelected: index == ordersCubit.isStageSelected,
                          onTap: () {
                            ordersCubit.setStage(
                              index: index,
                              stage: item.name,
                            );

                            setState(() {});
                          },
                        );
                      }),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainButton(
              buttonTile: AppStrings.filter,
              onPressed: () {
                final params =  OrderParams(
                  sortOrder: sortOrder,
                  stage: ordersCubit.selectedStage,
                  status: widget.selectedStatus,
                  sortBy: selectedOrderBy,
                  page: 1,
                );
                ordersCubit.getAllOrders(
                 params
                );

                context.pop(sortOrder);
              },
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

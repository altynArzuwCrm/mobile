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
  const FilterOrderWidget({super.key, required this.selectedStatus});

  final String? selectedStatus;

  @override
  State<FilterOrderWidget> createState() => _FilterOrderWidgetState();
}

class _FilterOrderWidgetState extends State<FilterOrderWidget> {
  String sortOrder = "asc";
  final ordersCubit = locator<OrdersCubit>();

  String? selectedCategory;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SortOrderSelector(
              sortOrder: sortOrder,
              isIconOnly: false,
              onChanged: (val) {
                setState(() => sortOrder = val);
                debugPrint("Sort order: $sortOrder");
              },
            ),
          ),
          SizedBox(height: 20),
          BlocBuilder<StageCubit, StageState>(
            builder: (context, state) {
              if (state is StageLoaded) {
                final data = state.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      CategoryBtn(
                        title: "Все",
                        isSelected: ordersCubit.isStageSelected == 0,
                        onTap: () {
                          setState(() {
                          //   isStageSelected = 0;
                          //   selectedStage = null;
                          });
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

                            setState(() {
                            //   isStageSelected = index;
                            //   selectedStage = item.name;
                            });
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MainButton(
              buttonTile: AppStrings.filter,
              onPressed: () {
                // log('${widget.selectedStatus}\n ${OrderParams(
                //   // page: _currentPage,
                //   stage: selectedStage,
                //   status: widget.selectedStatus,
                // ).toString()}');

                ordersCubit.getAllOrders(
                  OrderParams(
                    sortOrder: sortOrder,
                    stage: ordersCubit.selectedStage,
                    status: widget.selectedStatus,
                    page: 1,
                  ),
                );
                context.pop();
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

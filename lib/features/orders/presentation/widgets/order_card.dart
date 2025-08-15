import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/cubits/order_stage/order_stage_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/stages/presentation/cubits/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'custom_dropdown.dart';
import 'custom_radio_btn.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,

    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.hasSelected = false,
    required this.model,
  });

  final void Function()? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool hasSelected;
  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasSelected ? onTap : null,
      //     () {
      //   if (hasSelected && onTap != null) {
      //     onTap!();
      //   } else {}
      // },
      onLongPress: !hasSelected ? onLongPress : null,
      //     () {
      //   if (!hasSelected && onLongPress != null) {
      //     onLongPress!();
      //   }
      // },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: (isSelected) ? AppColors.lightBlue : AppColors.white,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<StageCubit, StageState>(
                  builder: (context, state) {
                    if (state is StageLoaded) {
                      return BlocBuilder<
                        OrderStageSelectionCubit,
                        Map<int, String?>
                      >(
                        builder: (context, selectionState) {
                          final selectedStage =
                              selectionState[model.id] ?? model.stage?.name;

                          return CustomDropdown(
                            value: selectedStage,
                            onChanged: (val) {
                              context.read<OrderStageSelectionCubit>().setStage(
                                model.id,
                                val,
                              );
                              // Optionally call API immediately
                              // context.read<OrderDetailCubit>().updateOrder(
                              //   CreateOrderParams(id: model.id, stageName: val),
                              // );
                              locator<OrdersCubit>().updateOrderStage(
                                val ?? '',
                                model.id,
                              );
                            },
                            bgColor: AppColors.white,
                            elevation: 12,
                            hintText: model.stage?.displayName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: AppColors.blue,
                            ),
                            items: state.data
                                .map(
                                  (stage) => DropdownMenuItem(
                                    value: stage.name,
                                    child: Text(stage.displayName),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      );
                    } else {
                      return CustomDropdown(
                        value: null,
                        onChanged: (val) {},
                        hintText: model.stage?.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.blue,
                        ),
                        items: [],
                      );
                    }
                  },
                ),

                hasSelected
                    ? CustomRadioButton(isSelected: isSelected)
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.project?.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ),
                Text(
                  AppStrings.project,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.normalGray,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(color: AppColors.divider, thickness: 1),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '2d 4h',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Text(
                //       AppStrings.responsible,
                //       style: TextStyle(
                //         fontWeight: FontWeight.w400,
                //         fontSize: 14,
                //         color: AppColors.normalGray,
                //       ),
                //     ),
                //     SizedBox(height: 2),
                //
                //     Text(
                //       'Марал Маралова',
                //       style: TextStyle(
                //         fontWeight: FontWeight.w400,
                //         fontSize: 12,
                //         color: AppColors.accent,
                //       ),
                //     ),
                //   ],
                // ),
                Column(
                  children: [
                    Text(
                      AppStrings.dedline,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 2),

                    Text(
                      model.deadline,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DecoratedContainer(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                //   strokeWidth: 1,
                //   dashSpace: 1,
                //   dashWidth: 1,
                //   cornerRadius: null,
                //   strokeColor: AppColors.black,
                //   child: Text(
                //     'В работе',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w400,
                //       fontSize: 12,
                //       color: AppColors.black,
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,

                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    AppStrings.acceptJob,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.green,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.red,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    AppStrings.reject,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.push('${AppRoutes.orderDetails}/${model.id}');
                  },
                  child: Text(
                    AppStrings.moreDetails,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

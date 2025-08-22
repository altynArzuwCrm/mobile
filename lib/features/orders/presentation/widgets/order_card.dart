import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/cubits/order_stage/order_stage_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_decorated_container/flutter_decorated_container.dart';
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

      onLongPress: !hasSelected ? onLongPress : null,

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is! UserLoaded) {
                      return _ReadOnlyDropdown(
                        hintText: model.stage?.displayName,
                      );
                    }

                    // Extract role IDs
                    final roles = userState.data.roles?.map((e) => e.id) ?? [];
                    final canEdit = roles.any((id) => id == 1 || id == 2);

                    return canEdit
                        ? _EditableStageDropdown(model: model)
                        : _ReadOnlyDropdown(hintText: model.stage?.displayName);
                  },
                ),

                hasSelected
                    ? CustomRadioButton(isSelected: isSelected)
                    : const SizedBox.shrink(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      model.createdAt??'',
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
                  crossAxisAlignment: CrossAxisAlignment.start,

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
                DecoratedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  strokeWidth: 1,
                  dashSpace: 1,
                  dashWidth: 1,
                  cornerRadius: null,
                  strokeColor: AppColors.black,
                  child: Text(
                  'В работе',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                //   decoration: BoxDecoration(
                //     color: AppColors.lightGreen,
                //
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: Text(
                //     AppStrings.acceptJob,
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: 12,
                //       color: AppColors.green,
                //     ),
                //   ),
                // ),
                //
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(4),
                //     border: Border.all(
                //       color: AppColors.red,
                //       style: BorderStyle.solid,
                //     ),
                //   ),
                //   child: Text(
                //     AppStrings.reject,
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: 12,
                //       color: AppColors.red,
                //     ),
                //   ),
                // ),
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

class _ReadOnlyDropdown extends StatelessWidget {
  final String? hintText;

  const _ReadOnlyDropdown({this.hintText});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      value: null,
      onChanged: (_) {},
      hintText: hintText,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: AppColors.blue,
      ),
      items: const [],
    );
  }
}

class _EditableStageDropdown extends StatelessWidget {
  final OrderModel model;

  const _EditableStageDropdown({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageCubit, StageState>(
      builder: (context, state) {
        if (state is! StageLoaded) {
          return _ReadOnlyDropdown(hintText: model.stage?.displayName);
        }

        return BlocBuilder<OrderStageSelectionCubit, Map<int, String?>>(
          builder: (context, selectionState) {
            final selectedStage = selectionState[model.id] ?? model.stage?.name;

            return CustomDropdown(
              value: selectedStage,
              // can be null safely
              onChanged: (val) {
                context.read<OrderStageSelectionCubit>().setStage(
                  model.id,
                  val,
                );
                locator<OrdersCubit>().updateOrderStage(val ?? '', model.id);
              },
              bgColor: AppColors.white,
              elevation: 12,
              hintText: model.stage?.displayName,
              style: const TextStyle(
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
      },
    );
  }
}

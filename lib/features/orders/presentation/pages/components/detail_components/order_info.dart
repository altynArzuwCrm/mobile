import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/widgets/details/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';

import 'assignments.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.model});

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allInfo,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 15),

          /// Project info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: InfoBlock(
                  title: AppStrings.projectTitle,
                  value: model.project?.title ?? '',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    final canEdit = userState is UserLoaded &&
                        (userState.data.roles?.any((r) => r.id == 1 || r.id == 2) ?? false);

                    if (!canEdit) {
                      return InfoBlock(
                        title: AppStrings.count,
                        value: '${model.quantity ?? 0}',
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InfoBlock(
                          title: AppStrings.sum,
                          value: '${model.project?.totalPrice ?? 0} тмт',
                        ),
                        const SizedBox(height: 8),
                        InfoBlock(
                          title: AppStrings.count,
                          value: '${model.quantity ?? 0}',
                        ),
                      ],
                    );
                  },
                ),
              )

            ],
          ),

          const SizedBox(height: 15),
          const Divider(color: AppColors.divider, thickness: 1),
          const SizedBox(height: 5),

          /// Responsible section + assignments
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final user = state is UserLoaded ? state.data : null;

              return AssignmentsSection(
                assignments: model.assignments,
                currentStage: model.currentStage?.displayName ?? '',
                currentUser: user,
              );
            },
          ),

          const SizedBox(height: 5),
          const Divider(color: AppColors.divider, thickness: 1),
          const SizedBox(height: 15),

          /// Dates
          InfoRow(title: AppStrings.start, value: model.createdAt),
          const SizedBox(height: 15),
          InfoRow(title: AppStrings.dedline, value: model.deadline),
        ],
      ),
    );
  }
}

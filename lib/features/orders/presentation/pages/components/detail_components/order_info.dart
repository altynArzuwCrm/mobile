import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/widgets/assignment_actions.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_decorated_container/flutter_decorated_container.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.model});

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    String currentStatus = '';

    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allInfo,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Название проекта',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      model.project?.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.sum,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${model.project?.totalPrice} тмт',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 15),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 5),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.responsible,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.normalGray,
                    ),
                  ),
                  DecoratedContainer(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    strokeWidth: 1,
                    dashSpace: 1,
                    dashWidth: 1,
                    cornerRadius: null,
                    strokeColor: AppColors.black,
                    child: Text(
                      model.currentStage?.displayName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              /// assignments list all
              // ...model.assignments.map((assignment) {
              //   final user = assignment.user;
              //   final role = user.roles
              //       .firstWhere(
              //         (r) => r.name.contains(assignment.roleType),
              //     orElse: () => user.roles.first,
              //   )
              //       .displayName;
              //
              //   return Padding(
              //     padding: const EdgeInsets.only(bottom: 6.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         /// user + role
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 user.name,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 15,
              //                   color: AppColors.darkBlue,
              //                 ),
              //               ),
              //               Text(
              //                 role,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 13,
              //                   color: AppColors.normalGray,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //
              //         /// status badge
              //         DecoratedContainer(
              //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //           strokeWidth: 1,
              //           dashSpace: 1,
              //           dashWidth: 1,
              //           cornerRadius: 6,
              //           strokeColor: assignment.status == 'pending'
              //               ? AppColors.orange
              //               : AppColors.green,
              //           child: Text(
              //             assignment.status,
              //             style: TextStyle(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 12,
              //               color: assignment.status == 'pending'
              //                   ? AppColors.orange
              //                   : AppColors.green,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // }).toList(),

              /// assignments list
              ...model.assignments
                  .where(
                    (assignment) =>
                        assignment.roleType == model.currentStage?.name,
                  )
                  .map((assignment) {
                    final user = assignment.user;
                    final role = user.roles
                        .firstWhere(
                          (r) => r.name.contains(assignment.roleType),
                          orElse: () => user.roles.first,
                        )
                        .displayName;

                    /// перевод статусов
                    final statusLabels = {
                      'pending': 'В ожидании',
                      'in_progress': 'В процессе',
                      'cancelled': 'Отменено',
                      'under_review': 'На проверке',
                      'approved': 'Одобрено',
                    };
                    currentStatus = assignment.status;

                    final statusText =
                        statusLabels[currentStatus] ?? currentStatus;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// user + role
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                                Text(
                                  role,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppColors.normalGray,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// status badge
                          DecoratedContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            strokeWidth: 1,
                            dashSpace: 1,
                            dashWidth: 1,
                            cornerRadius: 6,
                            strokeColor: assignment.status == 'pending'
                                ? AppColors.orange
                                : assignment.status == 'cancelled'
                                ? AppColors.red
                                : AppColors.green,
                            child: Text(
                              statusText,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: assignment.status == 'pending'
                                    ? AppColors.orange
                                    : assignment.status == 'cancelled'
                                    ? AppColors.red
                                    : AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),


            ],
          ),

          SizedBox(height: 5),

          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(
                model.createdAt,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          SizedBox(height: 15),
//todo items == null error
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                final roles = state.data.roles?.map((e) => e.id) ?? [];
                final admin = roles.any((id) => id == 1 || id == 2);
                print(roles);
                print(admin);
                print(currentStatus);

                return admin
                    ? AssignmentActions(
                        status: currentStatus,
                        onStatusChanged: (newStatus) {
                          currentStatus = newStatus;
                          print("Статус изменён на: $newStatus");
                        },
                      )
                    : SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

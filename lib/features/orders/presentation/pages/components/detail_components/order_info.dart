import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/presentation/widgets/details/info_card.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child: InfoBlock(
                  title: AppStrings.sum,
                  value: '${model.project?.totalPrice?? 0} тмт',
                ),
              ),
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

// class _AssignmentsSection extends StatelessWidget {
//   final List<AssignModel>? assignments;
//   final String currentStage;
//   final UserEntity? currentUser; // 👈 pass the logged-in user from UserCubit
//
//   const _AssignmentsSection({
//     required this.assignments,
//     required this.currentStage,
//     required this.currentUser,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final safeAssignments = assignments ?? [];
//
//     if (safeAssignments.isEmpty) {
//       return const Text(
//         "Нет назначений",
//         style: TextStyle(color: AppColors.normalGray),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Stage info
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               AppStrings.responsible,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.normalGray,
//               ),
//             ),
//             DecoratedContainer(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//               strokeWidth: 1,
//               dashSpace: 1,
//               dashWidth: 1,
//               cornerRadius: null,
//               strokeColor: AppColors.black,
//               child: Text(
//                 currentStage,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                   color: AppColors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//
//         /// assignments list
//         ...safeAssignments.map((assignment) {
//           final user = assignment.user;
//
//           //  Safe roles
//           final safeRoles = user.roles ?? [];
//           final role = safeRoles.isNotEmpty
//               ? safeRoles
//                     .firstWhere(
//                       (r) => r.name.contains(assignment.roleType),
//                       orElse: () => safeRoles.first,
//                     )
//                     .displayName
//               : 'Нет роли';
//
//           // Permission check
//           final isAdmin =
//               currentUser?.roles?.any((r) => r.id == 1 || r.id == 2) ?? false;
//           final isOwner = currentUser?.id == user.id;
//           final canEdit = isAdmin || isOwner;
//
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 /// user + role
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 15,
//                           color: AppColors.darkBlue,
//                         ),
//                       ),
//                       Text(
//                         role,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 13,
//                           color: AppColors.normalGray,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 /// dropdown if allowed, badge otherwise
//                 canEdit
//                     ? BlocProvider(
//                         create: (context) => locator<AssignCubit>(),
//                         child: BlocConsumer<AssignCubit, AssignState>(
//                           listener: (context, state) {
//                             if (state is AssignSuccess) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(state.message)),
//                               );
//                             } else if (state is AssignError) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(state.message),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                             }
//                           },
//                           builder: (context, state) {
//                             final isLoading = state is AssignLoading;
//
//                             return AssignmentActions(
//                               status: assignment.status,
//                               enabled: !isLoading,
//                               onStatusChanged: (newStatus) {
//                                 context
//                                     .read<AssignCubit>()
//                                     .updateOrderAssignmentStatus(
//                                       assignment.id,
//                                       newStatus,
//                                     );
//                               },
//                             );
//                           },
//                         ),
//                       )
//                     : DecoratedContainer(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         strokeWidth: 1,
//                         dashSpace: 1,
//                         dashWidth: 1,
//                         cornerRadius: 6,
//                         strokeColor: _statusColor(assignment.status),
//                         child: Text(
//                           _statusLabel(assignment.status),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                             color: _statusColor(assignment.status),
//                           ),
//                         ),
//                       ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
//
//   String _statusLabel(String status) {
//     const statusLabels = {
//       'pending': 'В ожидании',
//       'in_progress': 'В процессе',
//       'cancelled': 'Отменено',
//       'under_review': 'На проверке',
//       'approved': 'Одобрено',
//     };
//     return statusLabels[status] ?? status;
//   }
//
//   Color _statusColor(String status) {
//     switch (status) {
//       case 'pending':
//         return AppColors.orange;
//       case 'in_progress':
//         return AppColors.blue;
//       case 'under_review':
//         return Colors.purple;
//       case 'approved':
//         return AppColors.green;
//       case 'cancelled':
//         return AppColors.red;
//       default:
//         return AppColors.black;
//     }
//   }
// }

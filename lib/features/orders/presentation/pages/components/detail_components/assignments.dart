import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/assignments/data/models/assign_model.dart';
import 'package:crm/features/assignments/presentation/cubits/assign_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/assignment_actions.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_decorated_container/flutter_decorated_container.dart';

/// Assignments section
class AssignmentsSection extends StatelessWidget {
  final List<AssignModel>? assignments;
  final String currentStage;
  final UserEntity? currentUser;

  const AssignmentsSection({
    super.key,
    required this.assignments,
    required this.currentStage,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final safeAssignments = assignments ?? [];

    if (safeAssignments.isEmpty) {
      return const Text(
        "Нет назначений",
        style: TextStyle(color: AppColors.normalGray),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stage info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.responsible,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.normalGray,
              ),
            ),
            DecoratedContainer(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              strokeWidth: 1,
              dashSpace: 1,
              dashWidth: 1,
              cornerRadius: null,
              strokeColor: AppColors.black,
              child: Text(
                currentStage,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Provide single cubit for all assignments
        Column(
          children: safeAssignments.map((assignment) {
            final user = assignment.user;

            // Safe roles
            final safeRoles = user.roles;
            final role = safeRoles.isNotEmpty
                ? safeRoles
                      .firstWhere(
                        (r) => r.name.contains(assignment.roleType),
                        orElse: () => safeRoles.first,
                      )
                      .displayName
                : AppStrings.noRoles;

            // Permission check
            final isAdmin =
                currentUser?.roles?.any((r) => r.id == 1 || r.id == 2) ?? false;
            final isOwner = currentUser?.id == user.id;
            final canEdit = isAdmin || isOwner;

            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User + role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        Text(
                          role,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.normalGray,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dropdown if allowed, badge otherwise
                  canEdit
                      ? BlocConsumer<AssignCubit, AssignState>(
                          listenWhen: (previous, current) {
                            // Only listen to success/error states
                            return current is AssignSuccess ||
                                current is AssignError;
                          },
                          listener: (context, state) {
                            if (!context.mounted) return; // safe

                            String message;
                            Color? color;

                            if (state is AssignSuccess) {
                              message = state.message;
                              color = null; // default color
                            } else if (state is AssignError) {
                              message = state.message;
                              color = Colors.red;
                            } else {
                              return;
                            }

                            // Remove old SnackBars
                            ScaffoldMessenger.of(
                              context,
                            ).removeCurrentSnackBar();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: color,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          builder: (context, state) {
                            final isLoading =
                                state is AssignLoading &&
                                state.assignmentId == assignment.id;

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AssignmentActions(
                                  status: assignment.status,
                                  enabled: !isLoading,
                                  onStatusChanged: (newStatus) {
                                    context
                                        .read<AssignCubit>()
                                        .updateOrderAssignmentStatus(
                                          assignment.id,
                                          newStatus,
                                        );
                                  },
                                ),
                                if (isLoading) ...[
                                  const SizedBox(width: 8),
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        )
                      : DecoratedContainer(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          strokeWidth: 1,
                          dashSpace: 1,
                          dashWidth: 1,
                          cornerRadius: 6,
                          strokeColor: _statusColor(assignment.status),
                          child: Text(
                            _statusLabel(assignment.status),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: _statusColor(assignment.status),
                            ),
                          ),
                        ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _statusLabel(String status) {
    const statusLabels = {
      'pending': AppStrings.pending,
      'in_progress': AppStrings.progress,
      'cancelled': AppStrings.cancelled,
      'under_review': AppStrings.approve,
      'approved': AppStrings.approved,
    };
    return statusLabels[status] ?? status;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.orange;
      case 'in_progress':
        return AppColors.blue;
      case 'under_review':
        return Colors.purple;
      case 'approved':
        return AppColors.green;
      case 'cancelled':
        return AppColors.red;
      default:
        return AppColors.black;
    }
  }
}

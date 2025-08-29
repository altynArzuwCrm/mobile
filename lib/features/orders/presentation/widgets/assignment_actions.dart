import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

class AssignmentActions extends StatefulWidget {
  final String status;
  final ValueChanged<String>? onStatusChanged;
  final bool enabled;

  const AssignmentActions({
    super.key,
    required this.status,
    this.onStatusChanged,
    this.enabled = true,
  });

  @override
  State<AssignmentActions> createState() => _AssignmentActionsState();
}

class _AssignmentActionsState extends State<AssignmentActions> {
  late String _selectedStatus;

  final Map<String, String> statusLabels = {
    'pending': AppStrings.pending,
    'in_progress': AppStrings.progress,
    'cancelled': AppStrings.cancelled,
    'under_review': AppStrings.approve,
    'approved': AppStrings.approved,
  };

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: _statusColor(_selectedStatus)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<String>(
        value: _selectedStatus,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: _statusColor(_selectedStatus),
        ),
        items: statusLabels.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
        onChanged: widget.enabled
            ? (value) {
                if (value != null) {
                  setState(() => _selectedStatus = value);
                  widget.onStatusChanged?.call(value);
                }
              }
            : null,
      ),
    );
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

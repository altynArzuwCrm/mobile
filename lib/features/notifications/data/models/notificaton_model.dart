
import 'package:crm/core/utils/time_format.dart';

class NotificationModel {
  final int orderId;
  final int? projectId;
  // final String title;
  final int actionUserId;
  final String actionUserName;
  final String assignedUserName;
  final dynamic actionUserRole;
  final dynamic roleType;
  final dynamic stage;
  final String message;
  final String assignedAt;

  NotificationModel({
    required this.orderId,
    required this.projectId,
    // required this.title,
    required this.actionUserId,
    required this.actionUserName,
    required this.assignedUserName,
    required this.actionUserRole,
    required this.roleType,
    required this.stage,
    required this.message,
    required this.assignedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    orderId: json["order_id"],
    projectId: json["project_id"],
    // title: json["title"] ?? '',
    actionUserId: json["action_user_id"],
    actionUserName: json["action_user_name"]??'',
    assignedUserName: json["assigned_user_name"]??'',
    actionUserRole: json["action_user_role"],
    roleType: json["role_type"],
    stage: json["stage"],
    message: json["message"],
    assignedAt: json["changed_at"] != null ? formatDateTime(DateTime.parse(json["changed_at"])): '',
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "project_id": projectId,
    "action_user_id": actionUserId,
    "action_user_name": actionUserName,
    "action_user_role": actionUserRole,
    "role_type": roleType,
    "stage": stage,
    "message": message,
    "assigned_at": assignedAt,
  };
}

import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/users/data/models/user_model.dart';

class AssignModel {
  final int id;
  final int orderId;
  final int userId;
  final String status;
  final DateTime assignedAt;
  final dynamic completedAt;
  final dynamic cancelledAt;
  final dynamic approvedAt;
  final UserModel? assignedBy;
  final String roleType;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final UserModel user;

  AssignModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.status,
    required this.assignedAt,
    required this.completedAt,
    required this.cancelledAt,
    required this.approvedAt,
    required this.assignedBy,
    required this.roleType,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
  });

  factory AssignModel.fromJson(Map<String, dynamic> json) => AssignModel(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    status: json["status"],
    assignedAt: DateTime.parse(json["assigned_at"]),
    completedAt: json["completed_at"],
    cancelledAt: json["cancelled_at"],
    approvedAt: json["approved_at"],
    assignedBy: json["assigned_by_user"] != null ? UserModel.fromJson(json["assigned_by_user"]) : null,
    roleType: json["role_type"],
    createdAt: json["created_at"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',
    updatedAt: json["updated_at"] != null
        ? formatDate(DateTime.parse(json["updated_at"]))
        : '',
    deletedAt: json["deleted_at"],
    user: UserModel.fromJson(json["user"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "status": status,
    "assigned_at": assignedAt.toIso8601String(),
    "completed_at": completedAt,
    "cancelled_at": cancelledAt,
    "approved_at": approvedAt,
    "assigned_by_user": assignedBy?.toJson(),
    "role_type": roleType,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "user": user.toJson(),
  };


}

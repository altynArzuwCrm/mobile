import 'package:crm/features/users/data/models/user_model.dart';

class StageModel {
  final int id;
  final String name;
  final String displayName;
  // final dynamic description;
  // final int order;
  // final bool isActive;
  final String? color;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;
  // final dynamic deletedAt;
  // final List<RoleModel> roles;

  StageModel({
    required this.id,
    required this.name,
    required this.displayName,
    // required this.description,
    // required this.order,
    required this.color,
    // required this.createdAt,
    // required this.isActive,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.roles,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) => StageModel(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"],
    // description: json["description"],
    // order: json["order"],
    // isActive: json["is_active"] != null ? json["is_active"] == 1 ?true : false : false,
    color: json["color"] != null ?  json["color"] : null,
    // createdAt:json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    // updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    // deletedAt: json["deleted_at"],
    // roles: json["roles"] != null ? List<RoleModel>.from(
    //   json["roles"].map((x) => RoleModel.fromJson(x)),
    // ) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    // "description": description,
    // "order": order,
    "color": color,
    // "created_at": createdAt?.toIso8601String(),
    // "updated_at": updatedAt?.toIso8601String(),
    // "deleted_at": deletedAt,
  };
}


class RoleModel {
  final int id;
  final String name;
  final String displayName;
  final String description;
  final int usersCount;
  final List<Stage> stages;

  RoleModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.usersCount,
    required this.stages,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json["id"],
    name: json["name"]??'',
    displayName: json["display_name"]??'',
    description: json["description"]??'',
    usersCount: json["users_count"],
    stages: json["stages"] != null ? List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    "description": description,
    "users_count": usersCount,
    "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
  };
}

class Stage {
  final int id;
  final String name;
  final String displayName;
  final dynamic description;
  final int order;
  final String color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Stage({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.order,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"],
    description: json["description"],
    order: json["order"],
    color: json["color"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    "description": description,
    "order": order,
    "color": color,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}


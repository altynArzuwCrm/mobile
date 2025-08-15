import 'package:crm/features/users/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String? phone;
  final String? image;
  final bool isActive;
  final List<RoleModel>? roles;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.image,
    required this.isActive,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    phone: json["phone"],
    image: json["image"],
    isActive: json["is_active"] == 1 ? true : false,
    roles: json["roles"] != null
        ? List<RoleModel>.from(json["roles"].map((x) => RoleModel.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "image": image,
    "is_active": isActive,
    "roles": roles != null
        ? List<dynamic>.from(roles!.map((x) => x.toJson()))
        : null,
  };

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      phone: phone,
      image: image,
      isActive: isActive,
      roles: roles?.map((e) => e.toEntity()).toList(),
    );
  }
}

class RoleModel {
  final int id;
  final String name;
  final String displayName;
  final String description;

  RoleModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"] ?? '',
    description: json["description"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    "description": description,
  };

  RoleEntity toEntity() {
    return RoleEntity(
      id: id,
      name: name,
      displayName: displayName,
      description: description,
    );
  }
}

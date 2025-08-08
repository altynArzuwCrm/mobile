class UserModel {
  final UserDataModel user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: UserDataModel.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class UserDataModel {
  final int id;
  final String name;
  final String username;
  final String phone;
  final String image;
  final int isActive;
  final List<Role> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserDataModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.image,
    required this.isActive,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"]??0,
    name: json["name"]??'',
    username: json["username"]??'',
    phone: json["phone"]?.toString() ?? '',
    image: json["image"] ?? '',
    isActive: json["is_active"]??0,
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))??[],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "image": image,
    "is_active": isActive,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Role {
  final int id;
  final String name;
  final String displayName;

  Role({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"]??0,
    name: json["name"]??'',
    displayName: json["display_name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
  };
}

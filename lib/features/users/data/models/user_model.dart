import 'package:crm/features/users/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final dynamic phone;
  final dynamic image;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.image,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    phone: json["phone"] ?? '',
    image: json["image"] ?? '',
    isActive: json["is_active"] == 1 ? true : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "image": image,
    "is_active": isActive,
  };

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      phone: phone,
      image: image,
      isActive: isActive,
    );
  }
}

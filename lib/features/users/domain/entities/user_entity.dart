class UserEntity {
  final int id;
  final String name;
  final String username;
  final String? phone;
  final String? image;
  final bool isActive;
  final List<RoleEntity>? roles;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.image,
    required this.isActive,
    required this.roles,
  });
}


class RoleEntity {
  final int id;
  final String name;
  final String displayName;
  final String description;

  RoleEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
  });
}

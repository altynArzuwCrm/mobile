class User {
  final UserData user;
  final String token;

  User({required this.user, required this.token});
}

class UserData {
  final int id;
  final String name;
  final String username;
  final dynamic phone;
  final String image;
  final int isActive;
  final List<Role> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
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
}

class Role {
  final int id;
  final String name;
  final String displayName;

  Role({required this.id, required this.name, required this.displayName});
}

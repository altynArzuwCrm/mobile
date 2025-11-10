import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:crm/features/users/data/models/user_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String createdAt;
  final DateTime updatedAt;
  //final bool isActive;

  final List<Assignment> assignments;
  final List<StageModel> availableStages;

  ProductModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    //required this.isActive,

    required this.assignments,
    required this.availableStages,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    createdAt:json["created_at"] != null ? formatDate(DateTime.parse(json["created_at"])):'',
    updatedAt: DateTime.parse(json["updated_at"]),
   // isActive: json["is_active"] ?? false,

    assignments: json["assignments"] != null ? List<Assignment>.from(
      json["assignments"].map((x) => Assignment.fromJson(x)),
    ) : [],
    availableStages: json["available_stages"] != null ? List<StageModel>.from(
      json["available_stages"].map((x) => StageModel.fromJson(x)),
    ) : [],
  );
}

class Assignment {
  final int id;
  final int productId;
  final int userId;
  final String roleType;
  final bool isActive;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final UserModel user;

  Assignment({
    required this.id,
    required this.productId,
    required this.userId,
    required this.roleType,
    required this.isActive,
    // required this.createdAt,
    // required this.updatedAt,
    required this.user,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    roleType: json["role_type"],
    isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    user: UserModel.fromJson(json["user"]),
  );
}

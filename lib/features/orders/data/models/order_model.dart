import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';

class OrderModel {
  final int id;
  final int? clientId;
  final int? projectId;
  final int? productId;
  final int? stageId;
  final int? quantity;
  final String deadline;
  final String? price;
  final dynamic reason;
  final dynamic reasonStatus;
  final dynamic archivedAt;
  final bool? isArchived;
  final String? createdAt;
  final DateTime updatedAt;
  final Project? project;
  final Product? product;
  final ClientModel? client;
  final StageModel? stage;

  OrderModel({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.productId,
    required this.stageId,
    required this.quantity,
    required this.deadline,
    required this.price,
    required this.reason,
    required this.reasonStatus,
    required this.archivedAt,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.project,
    required this.product,
    required this.client,
    required this.stage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    clientId: json["client_id"],
    projectId: json["project_id"],
    productId: json["product_id"],
    stageId: json["stage_id"],
    quantity: json["quantity"],
    deadline: json["deadline"] != null
        ? formatDate(DateTime.parse(json["deadline"]))
        : '',
    price: json["price"],
    reason: json["reason"],
    reasonStatus: json["reason_status"],
    archivedAt: json["archived_at"],
    isArchived: json["is_archived"],
    createdAt:json["deadline"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',
    updatedAt: DateTime.parse(json["updated_at"]),
    project: json["project"] !=  null ? Project.fromJson(json["project"]) : null,
    product:json["product"] != null ? Product.fromJson(json["product"]) : null,
    client: json["client"] != null ? ClientModel.fromJson(json["client"]) : null,
    stage: json["stage"] != null ? StageModel.fromJson(json["stage"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "project_id": projectId,
    "product_id": productId,
    "stage_id": stageId,
    "quantity": quantity,
    "deadline": deadline,
    "price": price,
    "reason": reason,
    "reason_status": reasonStatus,
    "archived_at": archivedAt,
    "is_archived": isArchived,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "project": project?.toJson(),
    "product": product?.toJson(),
    "client": client?.toJson(),
    "stage": stage?.toJson(),
  };
}

class Product {
  final int id;
  final String name;
  // final int? hasDesignStage;
  // final int? hasPrintStage;
  // final int hasWorkshopStage;
  // final int hasEngravingStage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    // required this.hasDesignStage,
    // required this.hasPrintStage,
    // required this.hasWorkshopStage,
    // required this.hasEngravingStage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    // hasDesignStage: json["has_design_stage"] ?? null,
    // hasPrintStage: json["has_print_stage"]?? null,
    // hasWorkshopStage: json["has_workshop_stage"],
    // hasEngravingStage: json["has_engraving_stage"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    // "has_design_stage": hasDesignStage,
    // "has_print_stage": hasPrintStage,
    // "has_workshop_stage": hasWorkshopStage,
    // "has_engraving_stage": hasEngravingStage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Project {
  final int id;
  final String title;
  final DateTime deadline;
  final String totalPrice;
  final String paymentAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.title,
    required this.deadline,
    required this.totalPrice,
    required this.paymentAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    title: json["title"],
    deadline: DateTime.parse(json["deadline"]),
    totalPrice: json["total_price"],
    paymentAmount: json["payment_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "deadline": deadline.toIso8601String(),
    "total_price": totalPrice,
    "payment_amount": paymentAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';

class ProjectModel {
  final int id;
  final String title;
  final String? deadline;
  final String? totalPrice;
  final String? paymentAmount;
  final String createdAt;
  final DateTime updatedAt;
  final List<OrderModel>? orders;

  ProjectModel({
    required this.id,
    required this.title,
    required this.deadline,
    required this.totalPrice,
    required this.paymentAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["id"],
    title: json["title"] ?? '',
    deadline: json["deadline"] != null ? formatDate(DateTime.parse(json["deadline"])) : '',
    totalPrice: json["total_price"],
    paymentAmount: json["payment_amount"],
    createdAt: json["created_at"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',
    updatedAt: DateTime.parse(json["updated_at"]),
    orders: List<OrderModel>.from(
      json["orders"].map((x) => OrderModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "deadline": deadline,
    "total_price": totalPrice,
    "payment_amount": paymentAmount,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "orders": orders != null
        ? List<dynamic>.from(orders!.map((x) => x.toJson()))
        : [],
  };

  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      deadline: deadline,
      totalPrice: totalPrice,
      paymentAmount: paymentAmount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orders: orders != null ? orders!.map((e) => e.toEntity()).toList() : [],
    );
  }
}

class OrderModel {
  final int id;
  final int clientId;
  final int projectId;
  final int productId;
  final int stageId;
  final int quantity;
  final String deadline;
  final dynamic price;
  final dynamic reason;
  final dynamic reasonStatus;
  final dynamic archivedAt;
  final bool isArchived;
  final String createdAt;
  final DateTime updatedAt;
  final ClientModel product;
  final ClientModel client;

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
    required this.product,
    required this.client,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    clientId: json["client_id"],
    projectId: json["project_id"],
    productId: json["product_id"],
    stageId: json["stage_id"],
    quantity: json["quantity"],
    deadline: json["deadline"] != null ? formatDate(DateTime.parse(json["deadline"])) : '',

    price: json["price"],
    reason: json["reason"],
    reasonStatus: json["reason_status"],
    archivedAt: json["archived_at"],
    isArchived: json["is_archived"],
    createdAt: json["created_at"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',

    updatedAt: DateTime.parse(json["updated_at"]),
    product: json["product"] != null
        ? ClientModel.fromJson(json["product"])
        : ClientModel.empty(),
    client: json["client"] != null
        ? ClientModel.fromJson(json["client"])
        : ClientModel.empty(),
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
    "product": product.toJson(),
    "client": client.toJson(),
  };

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      clientId: clientId,
      projectId: projectId,
      productId: productId,
      stageId: stageId,
      quantity: quantity,
      deadline: deadline,
      price: price,
      reason: reason,
      reasonStatus: reasonStatus,
      archivedAt: archivedAt,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
      product: product.toEntity(),
      client: client.toEntity(),
    );
  }
}

import 'package:crm/features/clients/domain/entities/client_entity.dart';

class ProjectEntity {
  final int id;
  final String title;
  final DateTime? deadline;
  final String? totalPrice;
  final String? paymentAmount;
  final String createdAt;
  final DateTime updatedAt;
  final List<OrderEntity>? orders;

  ProjectEntity({
    required this.id,
    required this.title,
    required this.deadline,
    required this.totalPrice,
    required this.paymentAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

}

class OrderEntity {
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
  final ClientEntity product;
  final ClientEntity client;

  OrderEntity({
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

}


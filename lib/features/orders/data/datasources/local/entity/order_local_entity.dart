import 'package:crm/features/assignments/data/models/assign_model.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/orders/data/datasources/local/converter/assignment_list_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/client_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/generic_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/product_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/project_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/stage_converter.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:floor/floor.dart';

@entity
class OrderLocalEntity {
  @primaryKey
  final int id;

  final int? clientId;
  final int? projectId;
  final int? productId;
  final int? stageId;
  final int? quantity;

  final String deadline;
  final String? price;
  final String? reason;
  final String? reasonStatus;
  final String? archivedAt;
  final bool? isArchived;
  final String createdAt;

  @TypeConverters([DateTimeConverter])
  final DateTime updatedAt;

  @TypeConverters([ProjectConverter])
  final Project? project;

  @TypeConverters([ProductConverter])
  final Product? product;

  @TypeConverters([ClientConverter])
  final ClientModel? client;

  @TypeConverters([StageConverter])
  final StageModel? stage;

  @TypeConverters([StageConverter])
  final StageModel? currentStage;

  @TypeConverters([AssignmentListConverter])
  final List<AssignModel> assignments;

  OrderLocalEntity({
    required this.id,
    this.clientId,
    this.projectId,
    this.productId,
    this.stageId,
    this.quantity,
    required this.deadline,
    this.price,
    this.reason,
    this.reasonStatus,
    this.archivedAt,
    this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    this.project,
    this.product,
    this.client,
    this.stage,
    this.currentStage,
    required this.assignments,
  });

  factory OrderLocalEntity.fromModel(OrderModel model) => OrderLocalEntity(
    id: model.id,
    clientId: model.clientId,
    projectId: model.projectId,
    productId: model.productId,
    stageId: model.stageId,
    quantity: model.quantity,
    deadline: model.deadline,
    price: model.price,
    reason: model.reason?.toString(),
    reasonStatus: model.reasonStatus?.toString(),
    archivedAt: model.archivedAt?.toString(),
    isArchived: model.isArchived,
    createdAt: model.createdAt,
    updatedAt: model.updatedAt,
    project: model.project,
    product: model.product,
    client: model.client,
    stage: model.stage,
    currentStage: model.currentStage,
    assignments: model.assignments,
  );

  OrderModel toModel() {
    return OrderModel(
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
      project: project,
      product: product,
      client: client,
      stage: stage,
      currentStage: currentStage,
      assignments: assignments,
    );
  }
}

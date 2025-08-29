import 'package:crm/features/assignments/data/models/assign_model.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/orders/data/datasources/local/converter/generic_converter.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'orders')
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

  @TypeConverters([JsonConverter<Project>])
  final Project? project;

  @TypeConverters([JsonConverter<Product>])
  final Product? product;

  @TypeConverters([JsonConverter<ClientModel>])
  final ClientModel? client;

  @TypeConverters([JsonConverter<StageModel>])
  final StageModel? stage;

  @TypeConverters([JsonConverter<StageModel>])
  final StageModel? currentStage;

  @TypeConverters([JsonListConverter<AssignModel>])
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
}

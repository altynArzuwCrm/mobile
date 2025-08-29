import 'package:crm/features/assignments/data/models/assign_model.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/orders/data/datasources/local/converter/generic_converter.dart';
import 'package:crm/features/orders/data/datasources/local/dao/orders_dao.dart';
import 'package:crm/features/orders/data/datasources/local/entity/order_local_entity.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:floor/floor.dart';

@TypeConverters([
  DateTimeConverter,
  JsonConverter<Project>,
  JsonConverter<Product>,
  JsonConverter<ClientModel>,
  JsonConverter<StageModel>,
  JsonListConverter<AssignModel>,
])
@Database(version: 1, entities: [OrderLocalEntity])
abstract class AppDatabase extends FloorDatabase {
  OrderDao get orderDao;
}

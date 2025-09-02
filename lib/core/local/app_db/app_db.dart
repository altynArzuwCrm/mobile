import 'dart:async';

import 'package:crm/features/orders/data/datasources/local/converter/assignment_list_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/client_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/generic_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/product_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/project_converter.dart';
import 'package:crm/features/orders/data/datasources/local/converter/stage_converter.dart';
import 'package:crm/features/orders/data/datasources/local/dao/orders_dao.dart';
import 'package:crm/features/orders/data/datasources/local/entity/order_local_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_db.g.dart';

@TypeConverters([
  DateTimeConverter,
  ProjectConverter,
  ProductConverter,
  ClientConverter,
  StageConverter,
  AssignmentListConverter,
])
@Database(version: 1, entities: [OrderLocalEntity])
abstract class AppDataBase extends FloorDatabase {
  OrderDao get orderDao;
}

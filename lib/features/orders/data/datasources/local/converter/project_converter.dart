import 'dart:convert';

import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:floor/floor.dart';

class ProjectConverter extends TypeConverter<Project?, String?> {
  @override
  Project? decode(String? databaseValue) =>
      databaseValue == null ? null : Project.fromJson(jsonDecode(databaseValue));

  @override
  String? encode(Project? value) =>
      value == null ? null : jsonEncode(value.toJson());
}
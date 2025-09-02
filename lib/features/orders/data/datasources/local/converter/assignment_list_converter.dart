import 'dart:convert';

import 'package:crm/features/assignments/data/models/assign_model.dart';
import 'package:floor/floor.dart';

class AssignmentListConverter extends TypeConverter<List<AssignModel>, String> {
  @override
  List<AssignModel> decode(String databaseValue) {
    final list = jsonDecode(databaseValue) as List<dynamic>;
    return list.map((e) => AssignModel.fromJson(e)).toList();
  }

  @override
  String encode(List<AssignModel> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
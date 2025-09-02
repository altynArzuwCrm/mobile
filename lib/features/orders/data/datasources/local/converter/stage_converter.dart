import 'dart:convert';

import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:floor/floor.dart';

class StageConverter extends TypeConverter<StageModel?, String?> {
  @override
  StageModel? decode(String? databaseValue) => databaseValue == null
      ? null
      : StageModel.fromJson(jsonDecode(databaseValue));

  @override
  String? encode(StageModel? value) =>
      value == null ? null : jsonEncode(value.toJson());
}
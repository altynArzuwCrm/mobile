import 'dart:convert';

import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:floor/floor.dart';

class ClientConverter extends TypeConverter<ClientModel?, String?> {
  @override
  ClientModel? decode(String? databaseValue) => databaseValue == null
      ? null
      : ClientModel.fromJson(jsonDecode(databaseValue));

  @override
  String? encode(ClientModel? value) =>
      value == null ? null : jsonEncode(value.toJson());
}
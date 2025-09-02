import 'dart:convert';

import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:floor/floor.dart';

class ProductConverter extends TypeConverter<Product?, String?> {
  @override
  Product? decode(String? databaseValue) =>
      databaseValue == null ? null : Product.fromJson(jsonDecode(databaseValue));

  @override
  String? encode(Product? value) =>
      value == null ? null : jsonEncode(value.toJson());
}
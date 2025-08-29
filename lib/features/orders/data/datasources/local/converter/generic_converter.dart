import 'dart:convert';
import 'package:floor/floor.dart';

/// Generic converter for any object <-> JSON string
class JsonConverter<T> extends TypeConverter<T?, String?> {
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

 JsonConverter(this.fromJson, this.toJson);

  @override
  T? decode(String? databaseValue) =>
      databaseValue == null ? null : fromJson(jsonDecode(databaseValue));

  @override
  String? encode(T? value) =>
      value == null ? null : jsonEncode(toJson(value));
}

/// Converter for List<T>
class JsonListConverter<T> extends TypeConverter<List<T>, String> {
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  JsonListConverter(this.fromJson, this.toJson);


  @override
  List<T> decode(String databaseValue) {
    final list = jsonDecode(databaseValue) as List<dynamic>;
    return list.map((e) => fromJson(e)).toList();
  }

  @override
  String encode(List<T> value) =>
      jsonEncode(value.map((e) => toJson(e)).toList());
}

/// DateTime converter
class DateTimeConverter extends TypeConverter<DateTime, String> {

  @override
  DateTime decode(String databaseValue) => DateTime.parse(databaseValue);

  @override
  String encode(DateTime value) => value.toIso8601String();
}

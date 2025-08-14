import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';

class ClientModel {
  final int id;
  final String name;
  final String companyName;
  final String createdAt;
  final DateTime updatedAt;
  final List<ContactModel>? contacts;

  ClientModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.createdAt,
    required this.updatedAt,
    required this.contacts,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json["id"],
    name: json["name"]??'',
    companyName: json["company_name"]??'',
    createdAt:  json["created_at"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',
    updatedAt: DateTime.parse(json["updated_at"]),
    contacts: json["contacts"] != null ? List<ContactModel>.from(
      json["contacts"].map((x) => ContactModel.fromJson(x)),
    ) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "contacts": contacts != null ? List<dynamic>.from(contacts!.map((x) => x.toJson())) : null,
  };

  ClientEntity toEntity() {
    return ClientEntity(
      id: id,
      name: name,
      companyName: companyName,
      createdAt: createdAt,
      updatedAt: updatedAt,
      contacts: contacts?.map((e) => e.toEntity()).toList(),
    );
  }


  factory ClientModel.empty() {
    return ClientModel(
      id: 0,
      name: '',
      companyName: '',
      createdAt: '',
      updatedAt: DateTime.now(),
      contacts: [],
    );
  }
}

class ContactModel {
  final int id;
  final int clientId;
  final String type;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContactModel({
    required this.id,
    required this.clientId,
    required this.type,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    id: json["id"],
    clientId: json["client_id"],
    type: json["type"],
    value: json["value"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "type": type,
    "value": value,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      clientId: clientId,
      type: type,
      value: value,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

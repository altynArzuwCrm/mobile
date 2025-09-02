class ClientEntity {
  final int id;
  final String name;
  final String companyName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ContactEntity>? contacts;

  ClientEntity({
    required this.id,
    required this.name,
    required this.companyName,
    required this.createdAt,
    required this.updatedAt,
    required this.contacts,
  });
}


class ContactEntity {
  final int id;
  final int clientId;
  final String type;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContactEntity({
    required this.id,
    required this.clientId,
    required this.type,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });
}

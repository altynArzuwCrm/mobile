import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class CreateClientUseCase
    extends BaseUseCase<CreateClientParams, ClientEntity> {
  final ClientRepository repository;

  CreateClientUseCase({required this.repository});

  @override
  Future<Either<Failure, ClientEntity>> execute(input) async {
    return await repository.createClient(input);
  }
}

class CreateClientParams {
  final int? id;
  final String name;
  final String companyName;
  final List<ContactParam> contacts;

  CreateClientParams({
    required this.id,
    required this.name,
    required this.companyName,
    required this.contacts,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      "name": name,
      "company_name": companyName,
      "contacts": contacts.map((c) => c.toMap()).toList(),
    };
  }
}

class ContactParam {
  final String type;
  final String value;

  ContactParam({
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "value": value,
    };
  }
}

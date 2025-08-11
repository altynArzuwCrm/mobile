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
  final int id;
  final String name;
  final String companyName;
  final String email;
  final String phone;

  CreateClientParams({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['name'] = name;
    params['company_name'] = companyName;
    params['email'] = email;
    params['phone'] = phone;

    return params;
  }
}

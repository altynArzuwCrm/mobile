import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class CreateClientContactUseCase
    extends BaseUseCase<ClientContactParams, bool> {
  final ClientRepository repository;

  CreateClientContactUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.createClientContact(input);
  }
}

class ClientContactParams {
  final String type;
  final String value;
  final int id;

  ClientContactParams({required this.type, required this.value, required this.id});

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['type'] = type;
    params['value'] = value;

    return params;
  }
}

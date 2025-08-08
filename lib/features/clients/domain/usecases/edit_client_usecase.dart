import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

import 'create_client_usecase.dart';

class EditClientUseCase extends BaseUseCase<CreateClientParams, ClientEntity> {
  final ClientRepository repository;

  EditClientUseCase({required this.repository});

  @override
  Future<Either<Failure, ClientEntity>> execute(input) async {
    return await repository.editClient(input);
  }
}

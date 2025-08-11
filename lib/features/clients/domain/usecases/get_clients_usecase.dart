import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:dartz/dartz.dart';

class GetClientsUseCase extends BaseUseCase<UserParams, List<ClientEntity>> {
  final ClientRepository repository;

  GetClientsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ClientEntity>>> execute(input) async {
    return await repository.getAllClients(input);
  }
}

import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class GetClientByIdUseCase
    extends BaseUseCase<int, ClientEntity> {
  final ClientRepository repository;

  GetClientByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, ClientEntity>> execute(input) async {
    return await repository.getClientById(input);
  }
}
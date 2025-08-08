import 'package:crm/core/error/failure.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_contact_usecase.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../projects/domain/usecases/get_all_projects_usecase.dart' show ProjectParams;

abstract class ClientRepository {
  Future<Either<Failure, List<ClientEntity>>> getAllClients(ProjectParams params);
  Future<Either<Failure, ClientEntity>> getClientById(int id);
  Future<Either<Failure, ClientEntity>> createClient(CreateClientParams params);
  Future<Either<Failure, ClientEntity>> editClient(CreateClientParams params);
  Future<Either<Failure, bool>> deleteClient(int id);

  Future<Either<Failure, bool>> createClientContact(ClientContactParams params);
  Future<Either<Failure, bool>> editClientContact(ClientContactParams params);
  Future<Either<Failure, bool>> deleteClientContact(int id);


}

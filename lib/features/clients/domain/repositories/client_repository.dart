import 'package:crm/core/error/failure.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_contact_usecase.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:dartz/dartz.dart';

abstract class ClientRepository {
  Future<Either<Failure, List<ClientEntity>>> getAllClients(UserParams params);

  Future<Either<Failure, ClientEntity>> getClientById(int id);

  Future<Either<Failure, ClientEntity>> createClient(CreateClientParams params);

  Future<Either<Failure, ClientEntity>> editClient(CreateClientParams params);

  Future<Either<Failure, List<ClientEntity>>> deleteClient(int id);

  Future<Either<Failure, List<String>>> getCompanies();

  Future<Either<Failure, List<ClientEntity>>> getCompanyDetails(String title);

  Future<Either<Failure, bool>> createClientContact(ClientContactParams params);

  Future<Either<Failure, bool>> editClientContact(ClientContactParams params);

  Future<Either<Failure, bool>> deleteClientContact(int id);
}

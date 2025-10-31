import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/clients/data/datasources/remote/client_datasources.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:crm/features/clients/domain/usecases/create_client_contact_usecase.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:dartz/dartz.dart';

class ClientRepositoryImpl implements ClientRepository {
  final NetworkInfo networkInfo;

  final ClientRemoteDataSource remoteDataSource;

  ClientRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, ClientEntity>> createClient(
    CreateClientParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createClient(params);

        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> createClientContact(
    ClientContactParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createClientContact(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> deleteClient(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteClient(id);
        final result = response.map((e) => e.toEntity()).toList();

        return Right(result);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteClientContact(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteClientContact(id);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> editClient(
    CreateClientParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.editClient(params);
        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> editClientContact(
    ClientContactParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.editClientContact(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getAllClients(
    UserParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // try {
        final response = await remoteDataSource.getAllClients(params);
        final result = response.map((e) => e.toEntity()).toList();
        return Right(result);
      // } catch (error) {
      //   return Left(ServerFailure('[Server]: $error'));
      // }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> getClientById(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getClientById(id);
        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCompanies() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCompanies();
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getCompanyDetails(
    String title,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCompanyDetails(title);
        final result = response.map((e) => e.toEntity()).toList();

        return Right(result);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

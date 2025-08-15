import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/users/data/datasources/remote/user_datasources.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:crm/features/users/domain/entities/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;

  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> createUser(
    CreateUserParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createUser(params);
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
  Future<Either<Failure, List<UserEntity>>> deleteUser(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteUser(id);
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
  Future<Either<Failure, UserEntity>> editUser(CreateUserParams params) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.editUser(params);
        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers(
    UserParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllUsers(params);
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
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCurrentUser();
        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getUserById(id);
        return Right(response.toEntity());
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> getUsersByRole() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getUsersByRole();
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleUserActive() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.toggleUserActive();
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

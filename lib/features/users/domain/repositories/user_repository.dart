import 'package:crm/core/error/failure.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_params.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, List<UserEntity>>> getAllUsers(UserParams params);

  Future<Either<Failure, UserEntity>> getUserById(int id);

  Future<Either<Failure, UserEntity>> createUser(CreateUserParams params);

  Future<Either<Failure, UserEntity>> editUser(CreateUserParams params);

  Future<Either<Failure, bool>> deleteUser(int id);

  Future<Either<Failure, bool>> getUsersByRole();

  Future<Either<Failure, bool>> toggleUserActive();
}

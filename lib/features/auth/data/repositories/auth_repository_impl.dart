import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:crm/features/auth/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, void>> login(LoginParams params) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
     try {
        final response = await remoteDataSource.login(params);
        return Right(response);
      } catch (error) {
        return const Left(ServerFailure(''));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.logout();
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('$error'));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/roles/data/datasources/role_remote_datasource.dart';
import 'package:crm/features/roles/data/models/role_model.dart';
import 'package:dartz/dartz.dart';

class RoleRepository {
  final NetworkInfo networkInfo;

  final RoleRemoteDatasource remoteDataSource;

  RoleRepository(this.networkInfo, this.remoteDataSource);

  Future<Either<Failure, List<RoleModel>>> getAllRoles() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllRoles();
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

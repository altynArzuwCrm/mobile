import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/assignments/data/datasources/assignment_datasources.dart';
import 'package:crm/features/assignments/data/models/assign_order_params.dart';
import 'package:crm/features/orders/data/models/comment_model.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:dartz/dartz.dart';

class AssignmentRepository {
  final NetworkInfo networkInfo;

  final AssignmentDataSources remoteDataSource;

  AssignmentRepository(this.networkInfo, this.remoteDataSource);

  Future<Either<Failure, bool>> assignOrderToUser(
    AssignOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.assignOrderToUser(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, bool>> bulkAssignOrders(
    BulkAssignOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.bulkAssignOrders(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

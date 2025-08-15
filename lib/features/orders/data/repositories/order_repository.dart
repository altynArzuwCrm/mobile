import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/orders/data/models/comment_model.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:dartz/dartz.dart';

class OrderRepository {
  final NetworkInfo networkInfo;

  final OrderRemoteDataSource remoteDataSource;

  OrderRepository(this.networkInfo, this.remoteDataSource);

  Future<Either<Failure, List<OrderModel>>> getAllOrders(
    OrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllOrders(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, OrderModel>> getOrderById(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getOrderById(id);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, OrderModel>> createOrder(
    CreateOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createOrder(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, OrderModel>> editOrder(
    CreateOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.editOrder(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, bool>> deleteOrder(int id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteOrder(id);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, OrderModel>> editOrderStage(
    String stage,
    int orderId,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // try {
        final response = await remoteDataSource.editOrderStage(stage, orderId);
        return Right(response);
      // } catch (error) {
      //   return Left(ServerFailure('[Server]: $error'));
      // }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, bool>> moveOrderToNextStage(
    CreateOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.moveOrderToNextStage(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, bool>> getOrderStatusLogs(
    CreateOrderParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getOrderStatusLogs(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, List<CommentModel>>> getOrderComments(
    int orderId,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getOrderComments(orderId);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, List<CommentModel>>> createOrderComment(
    CommentParams params,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createOrderComment(params);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, List<CommentModel>>> deleteOrderComment(
    int id,
    int orderId,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteOrderComment(id, orderId);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

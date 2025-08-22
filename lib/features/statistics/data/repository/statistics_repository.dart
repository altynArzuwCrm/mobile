import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/statistics/data/datasources/statistics_remote_datasource.dart';
import 'package:crm/features/statistics/data/models/activity_model.dart';
import 'package:crm/features/statistics/data/models/last_activity_model.dart';
import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:crm/features/statistics/data/models/statistics_model.dart';
import 'package:dartz/dartz.dart';

class StatisticsRepository {
  final NetworkInfo networkInfo;

  final StatisticsRemoteDatasource remoteDataSource;

  StatisticsRepository(this.networkInfo, this.remoteDataSource);

  Future<Either<Failure, StatisticsModel>> getRevenue(int year) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
      final response = await remoteDataSource.getRevenue(year);
      return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, OrderStatModel>> getUserStats() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
      final response = await remoteDataSource.getUserStats();
      return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, ActivityModel>> getAllActivity() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
      final response = await remoteDataSource.getAllActivity();
      return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  Future<Either<Failure, List<LastActivityModel>>> getLastActivities() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
      final response = await remoteDataSource.getLastActivities();
      return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

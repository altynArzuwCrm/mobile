import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:crm/features/notifications/data/models/notificaton_model.dart';
import 'package:dartz/dartz.dart';

class NotificationRepository {
  final NetworkInfo networkInfo;

  final NotificationRemoteDatasource remoteDataSource;

  NotificationRepository(this.networkInfo, this.remoteDataSource);

  Future<Either<Failure, List<NotificationModel>>> getAllNotifications(int page) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllNotifications(page);
        return Right(response);
      } catch (error) {
        return Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}

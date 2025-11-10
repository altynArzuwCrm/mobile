import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/notifications/data/models/notificaton_model.dart';

abstract class NotificationRemoteDatasource {
  Future<List<NotificationModel>> getAllNotifications(int page);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDatasource {
  final ApiProvider apiProvider;

  NotificationRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<NotificationModel>> getAllNotifications(int page) async{

    final response = await apiProvider.get(
      endPoint: ApiEndpoints.notifications,
      query: {'page':page}
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => NotificationModel.fromJson(e['data'])).toList();


    return result;
  }
}

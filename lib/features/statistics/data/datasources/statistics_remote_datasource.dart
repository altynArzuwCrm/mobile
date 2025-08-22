import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/statistics/data/models/activity_model.dart';
import 'package:crm/features/statistics/data/models/last_activity_model.dart';
import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:crm/features/statistics/data/models/statistics_model.dart';

abstract class StatisticsRemoteDatasource {
  Future<StatisticsModel> getRevenue(int year);

  Future<OrderStatModel> getUserStats();

  Future<ActivityModel> getAllActivity();

  Future<List<LastActivityModel>> getLastActivities();
}

class StatisticsRemoteDatasourceImpl implements StatisticsRemoteDatasource {
  final ApiProvider apiProvider;

  StatisticsRemoteDatasourceImpl(this.apiProvider);

  @override
  Future<StatisticsModel> getRevenue(int year) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.stats,
      query: {"year": year},
    );

    final result = response.data;

    return StatisticsModel.fromJson(result);
  }

  @override
  Future<OrderStatModel> getUserStats() async {
    final response = await apiProvider.get(endPoint: ApiEndpoints.userStats);

    final result = response.data;

    return OrderStatModel.fromJson(result);
  }

  @override
  Future<List<LastActivityModel>> getLastActivities() async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.recentActivity,
    );

    final responseBody = response.data as List;

    final result = responseBody
        .map((e) => LastActivityModel.fromJson(e))
        .toList();

    return result;
  }

  @override
  Future<ActivityModel> getAllActivity() async {
    final response = await apiProvider.get(endPoint: ApiEndpoints.activity);

    final result = response.data;

    return ActivityModel.fromJson(result);
  }
}

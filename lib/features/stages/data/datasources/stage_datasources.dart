import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:crm/features/users/data/models/user_model.dart';

abstract class StageRemoteDataSources {
  Future<List<StageModel>> getAllStages();

  Future<void> getStageById();

  Future<void> createStage();

  Future<void> updateStage();

  Future<void> deleteStage();

  Future<void> reorderStages();

  Future<void> getAvailableRoles();

  Future<void> getUsersByStageRoles();

  Future<Map<StageModel, List<UserModel>>> getAllUsersByStageRoles();
}

class StageRemoteDataSourceImpl extends StageRemoteDataSources {
  final ApiProvider apiProvider;

  StageRemoteDataSourceImpl(this.apiProvider);


  @override
  Future<List<StageModel>> getAllStages() async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.stages,
    );

    final responseBody = response.data as List;

    final result = responseBody.map((e) => StageModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<void> createStage() async {
    // TODO: implement createStage
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStage() async {
    // TODO: implement deleteStage
    throw UnimplementedError();
  }


  @override
  Future<Map<StageModel, List<UserModel>>> getAllUsersByStageRoles() async {
    final responses = await Future.wait([
      apiProvider.get(endPoint: ApiEndpoints.stages),
      apiProvider.get(endPoint: '${ApiEndpoints.stages}/users-by-roles/all'),
    ]);

    final stagesResponse = responses[0];
    final usersResponse  = responses[1];

    // Parse data
    final usersData = usersResponse.data as Map<String, dynamic>;
    final stagesData = (stagesResponse.data as List)
        .map((e) => StageModel.fromJson(e))
        .toList();

    // Build map
    final Map<StageModel, List<UserModel>> stageUsersMap = {};

    for (var stage in stagesData) {
      final stageUsersJson = usersData[stage.id.toString()] as List?;
      if (stageUsersJson != null && stageUsersJson.isNotEmpty) {
        stageUsersMap[stage] =
            stageUsersJson.map((e) => UserModel.fromJson(e)).toList();
      }
    }

    return stageUsersMap;
  }



  @override
  Future<void> getAvailableRoles() async {
    // TODO: implement getAvailableRoles
    throw UnimplementedError();
  }

  @override
  Future<void> getStageById() async {
    // TODO: implement getStageById
    throw UnimplementedError();
  }

  @override
  Future<void> getUsersByStageRoles() async {
    // TODO: implement getUsersByStageRoles
    throw UnimplementedError();
  }

  @override
  Future<void> reorderStages() async {
    // TODO: implement reorderStages
    throw UnimplementedError();
  }

  @override
  Future<void> updateStage() async {
    // TODO: implement updateStage
    throw UnimplementedError();
  }
}

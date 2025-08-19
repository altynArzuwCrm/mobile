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

  Future<List<UserModel>> getAllUsersByStageRoles();
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
  Future<List<UserModel>> getAllUsersByStageRoles() async {



    // TODO: implement getAllUsersByStageRoles
    throw UnimplementedError();
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

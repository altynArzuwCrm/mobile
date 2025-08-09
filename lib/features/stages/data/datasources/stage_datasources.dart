import 'package:crm/core/network/api_provider.dart';

abstract class StageRemoteDataSources {
  Future<void> getAllStages();

  Future<void> getStageById();

  Future<void> createStage();

  Future<void> updateStage();

  Future<void> deleteStage();

  Future<void> reorderStages();

  Future<void> getAvailableRoles();

  Future<void> getUsersByStageRoles();

  Future<void> getAllUsersByStageRoles();
}

class StageRemoteDataSourceImpl extends StageRemoteDataSources {
  final ApiProvider apiProvider;

  StageRemoteDataSourceImpl(this.apiProvider);

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
  Future<void> getAllStages() async {
    // TODO: implement getAllStages
    throw UnimplementedError();
  }

  @override
  Future<void> getAllUsersByStageRoles() async {
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

part of 'stage_with_users_cubit.dart';

sealed class StageWithUsersState {}

final class StageWithUsersLoading extends StageWithUsersState {}
final class StageWithUsersLoaded extends StageWithUsersState {
  final Map<StageModel, List<UserModel>> stageUsersMap;

  StageWithUsersLoaded(this.stageUsersMap);

}
final class StageWithUsersError extends StageWithUsersState {
  final String message;

  StageWithUsersError(this.message);

}

part of 'stage_cubit.dart';

@immutable
sealed class StageState {}

final class StageLoading extends StageState {}
final class StageLoaded extends StageState {
  final List<StageModel> data;

  StageLoaded(this.data);
}
final class StageError extends StageState {}

part of 'all_activity_cubit.dart';

sealed class AllActivityState {}

final class AllActivityLoading extends AllActivityState {}
final class AllActivityLoaded extends AllActivityState {
  final ActivityModel data;

  AllActivityLoaded(this.data);
}
final class AllActivityError extends AllActivityState {}

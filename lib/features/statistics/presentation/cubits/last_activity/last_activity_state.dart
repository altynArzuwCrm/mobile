part of 'last_activity_cubit.dart';

sealed class LastActivityState {}

final class LastActivityLoading extends LastActivityState {}

final class LastActivityLoaded extends LastActivityState {
  final List<LastActivityModel> data;

  LastActivityLoaded(this.data);
}

final class LastActivityError extends LastActivityState {}

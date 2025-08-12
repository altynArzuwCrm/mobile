part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  final List<NotificationModel> data;

  NotificationLoaded(this.data);
}

final class NotificationConnectionError extends NotificationState {}

final class NotificationError extends NotificationState {}

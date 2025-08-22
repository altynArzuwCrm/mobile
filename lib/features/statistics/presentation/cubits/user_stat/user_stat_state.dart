part of 'user_stat_cubit.dart';

@immutable
sealed class UserStatState {}

final class UserStatLoading extends UserStatState {}
final class UserStatLoaded extends UserStatState {
  final OrderStatModel data;

  UserStatLoaded(this.data);
}
final class UserStatError extends UserStatState {}

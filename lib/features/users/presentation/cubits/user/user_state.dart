part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserLoading extends UserState {}
final class UserLoaded extends UserState {
  final UserEntity data;

  UserLoaded(this.data);
}
final class UserError extends UserState {}
final class UserConnectionError extends UserState {}

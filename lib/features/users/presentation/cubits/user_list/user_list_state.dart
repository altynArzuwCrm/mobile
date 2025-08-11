part of 'user_list_cubit.dart';

sealed class UserListState {}


final class UserListLoading extends UserListState {}

final class UserListLoaded extends UserListState {
  final List<UserEntity> data;

  UserListLoaded(this.data);
}

final class UserListError extends UserListState {}

final class UserListConnectionError extends UserListState {}

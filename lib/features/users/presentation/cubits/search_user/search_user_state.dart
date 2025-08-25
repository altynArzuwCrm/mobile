part of 'search_user_cubit.dart';

@immutable
sealed class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchFoundedUser extends SearchUserState {
  final List<UserEntity> data;
  SearchFoundedUser(this.data,);
}

final class SearchNotFoundedUser extends SearchUserState {}

final class SearchUserConnectionError extends SearchUserState {}

final class SearchUserError extends SearchUserState {}
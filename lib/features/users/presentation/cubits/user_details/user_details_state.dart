part of 'user_details_cubit.dart';

sealed class UserDetailsState {}

final class UserDetailsLoading extends UserDetailsState {}


final class UserDetailsLoaded extends UserDetailsState {
  final UserEntity data;

  UserDetailsLoaded(this.data);
}

final class UserDetailsError extends UserDetailsState {}

final class UserDetailsConnectionError extends UserDetailsState {}

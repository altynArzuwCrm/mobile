part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LogInEvent extends AuthEvent {
  final LoginParams params;
  final bool remember;

  LogInEvent(this.params, this.remember);


  List<Object?> get props => [params, remember];
}

final class LogOutEvent extends AuthEvent {}

final class CheckAuthEvent extends AuthEvent {}

final class InitialEvent extends AuthEvent {}

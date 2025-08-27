part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LogInEvent extends AuthEvent {
  final LoginParams params;

  LogInEvent(this.params);
}

final class LogOutEvent extends AuthEvent {}

final class CheckAuthEvent extends AuthEvent {}

final class InitialEvent extends AuthEvent {}

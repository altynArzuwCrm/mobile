part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LogInEvent extends AuthEvent {
  final LoginParams params;

  LogInEvent(this.params);
}

// final class SignUpEvent extends AuthEvent {
//   final SignUpParams params;
//
//   SignUpEvent(this.params);
// }

final class LogOutEvent extends AuthEvent {}

final class CheckAuthEvent extends AuthEvent {}
final class InitialEvent extends AuthEvent {}
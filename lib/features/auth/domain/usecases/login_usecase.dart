import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends BaseUseCase<LoginParams, void> {
  final AuthenticationRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(LoginParams input) async {
    return await repository.login(input);
  }
}

class LoginParams extends Equatable {
  final String password;
  final String username;

  const LoginParams({required this.password, required this.username});

  @override
  List<Object?> get props => [password, username];
}

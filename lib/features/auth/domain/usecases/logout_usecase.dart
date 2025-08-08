import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements BaseUseCase<NoParams, bool> {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.logout();
  }
}

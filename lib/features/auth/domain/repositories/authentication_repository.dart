import 'package:crm/core/error/failure.dart';
import 'package:crm/features/auth/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> login(LoginParams params);

  Future<Either<Failure, bool>> logout();
}

import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';


class CreateUserByRoleUseCase extends BaseUseCase<NoParams, bool> {
  final UserRepository repository;

  CreateUserByRoleUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.getUsersByRole();
  }
}

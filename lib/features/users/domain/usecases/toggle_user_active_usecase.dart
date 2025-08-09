import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ToggleUserActiveUseCase extends BaseUseCase<int, bool> {
  final UserRepository repository;

  ToggleUserActiveUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.toggleUserActive();
  }
}

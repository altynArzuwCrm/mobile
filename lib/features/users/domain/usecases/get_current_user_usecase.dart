import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase extends BaseUseCase<NoParams, UserEntity> {
  final UserRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> execute(input) async {
    return await repository.getCurrentUser();
  }
}

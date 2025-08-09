import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUseCase extends BaseUseCase<int, UserEntity> {
  final UserRepository repository;

  GetUserByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> execute(input) async {
    return await repository.getUserById(input);
  }
}

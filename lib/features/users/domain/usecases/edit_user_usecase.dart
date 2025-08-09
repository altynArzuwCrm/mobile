import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class EditUserUseCase extends BaseUseCase<CreateUserParams, UserEntity> {
  final UserRepository repository;

  EditUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> execute(input) async {
    return await repository.editUser(input);
  }
}

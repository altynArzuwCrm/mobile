import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

import 'create_project_usecase.dart';

class EditProjectUseCase
    extends BaseUseCase<CreateProjectParams, ProjectEntity> {
  final ProjectRepository repository;

  EditProjectUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectEntity>> execute(
    CreateProjectParams input,
  ) async {
    return await repository.editProject(input);
  }
}

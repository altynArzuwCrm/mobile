import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class GetProjectByIdUseCase extends BaseUseCase<int, ProjectEntity> {
  final ProjectRepository repository;

  GetProjectByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectEntity>> execute(int input) async {
    return await repository.getProjectById(input);
  }
}


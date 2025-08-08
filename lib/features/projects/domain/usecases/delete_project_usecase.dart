import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProjectUseCase extends BaseUseCase<int, bool> {
  final ProjectRepository repository;

  DeleteProjectUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(int input) async {
    return await repository.deleteProject(input);
  }
}


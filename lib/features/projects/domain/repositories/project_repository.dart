import 'package:crm/core/error/failure.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects(ProjectParams params);
  Future<Either<Failure, ProjectEntity>> getProjectById(int id);
  Future<Either<Failure, ProjectEntity>> createProject(CreateProjectParams params);
  Future<Either<Failure, ProjectEntity>> editProject(CreateProjectParams params);
  Future<Either<Failure, bool>> deleteProject(int id);

}

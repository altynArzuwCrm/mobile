import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProjectUseCase
    extends BaseUseCase<CreateProjectParams, ProjectEntity> {
  final ProjectRepository repository;

  CreateProjectUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectEntity>> execute(
    CreateProjectParams input,
  ) async {
    return await repository.createProject(input);
  }
}

class CreateProjectParams {
  final String title;
  final String description;
  final int clientId;
  final String? status;
  final int? id;

  CreateProjectParams({
    this.status,
    required this.title,
    required this.description,
    required this.clientId,
    this.id,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['title'] = title;
    params['description'] = description;
    params['client_id'] = clientId;
    if (status != null) params['status'] = status;

    return params;
  }
}

import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllProjectsUseCase
    extends BaseUseCase<ProjectParams, List<ProjectEntity>> {
  final ProjectRepository repository;

  GetAllProjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ProjectEntity>>> execute(
    ProjectParams input,
  ) async {
    return await repository.getAllProjects(input);
  }
}

class ProjectParams extends Equatable {
  final int? page;
  final String? search;
  final int? sortBy;
  final String? sortOrder;
  final int perPage;

  const ProjectParams({
    this.page,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.perPage = 30,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    if (page != null) params['page'] = page;
    if (search != null) params['search'] = search?.trim();
    if (sortBy != null) params['sort_by'] = sortBy;
    if (sortOrder != null) params['sort_order'] = sortOrder;
    params['per_page'] = perPage;

    return params;
  }

  @override
  List<Object?> get props => [page, search, sortBy, sortOrder, perPage];
}

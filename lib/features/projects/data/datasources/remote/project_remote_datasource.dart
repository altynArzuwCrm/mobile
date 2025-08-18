import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/projects/data/models/project_model.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getAllProjects(ProjectParams params);

  Future<ProjectModel> getProjectById(int id);

  Future<ProjectModel> createProject(CreateProjectParams params);

  Future<ProjectModel> editProject(CreateProjectParams params);

  Future<bool> deleteProject(int id);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final ApiProvider apiProvider;

  ProjectRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<ProjectModel> createProject(CreateProjectParams params) async {
    final response = await apiProvider.post(endPoint: ApiEndpoints.projects,
      data: params.toQueryParameters(),

    );
    final result = response.data;
    return ProjectModel.fromJson(result);
  }

  @override
  Future<bool> deleteProject(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.projects}/$id',
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ProjectModel> editProject(CreateProjectParams params) async {
    final response = await apiProvider.put(
      endPoint:  '${ApiEndpoints.projects}/${params.id}',
      data: params.toQueryParameters(),
    );
    final result = response.data;
    return ProjectModel.fromJson(result);
  }

  @override
  Future<List<ProjectModel>> getAllProjects(ProjectParams params) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.projects,
      query: params.toQueryParameters(),
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => ProjectModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<ProjectModel> getProjectById(int id) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.projects}/$id',
    );

    final result = response.data;
    return ProjectModel.fromJson(result);
  }
}

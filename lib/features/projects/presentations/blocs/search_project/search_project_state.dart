part of 'search_project_cubit.dart';

@immutable
sealed class SearchProjectState {}

final class SearchProjectInitial extends SearchProjectState {}


final class SearchProjectLoading extends SearchProjectState {}

final class SearchFoundedProjects extends SearchProjectState {
  final List<ProjectEntity> data;
  final String? selectedProject;

  SearchFoundedProjects(this.data, {this.selectedProject});

  SearchFoundedProjects copyWith({
    List<ProjectEntity>? data,
    String? selectedProject,
  }) {
    return SearchFoundedProjects(
      data ?? this.data,
      selectedProject: selectedProject ?? this.selectedProject,
    );
  }
}

final class SearchNotFoundedProjects extends SearchProjectState {}

final class SearchProjectsConnectionError extends SearchProjectState {}

final class SearchProjectsError extends SearchProjectState {}


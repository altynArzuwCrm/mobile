part of 'projects_bloc.dart';

sealed class ProjectsState {}

final class ProjectsLoading extends ProjectsState {}

final class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> data;

  ProjectsLoaded(this.data);
}

final class ProjectsError extends ProjectsState {}

final class ProjectsConnectionError extends ProjectsState {}

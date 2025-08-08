part of 'project_details_bloc.dart';

sealed class ProjectDetailsState {}

final class ProjectDetailLoading extends ProjectDetailsState {}

final class ProjectDetailLoaded extends ProjectDetailsState {
  final ProjectEntity data;

  ProjectDetailLoaded(this.data);
}

final class ProjectDetailError extends ProjectDetailsState {}

final class ProjectDetailConnectionError extends ProjectDetailsState {}

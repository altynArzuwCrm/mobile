part of 'project_details_bloc.dart';

sealed class ProjectDetailsEvent {}

final class GetProjectById extends ProjectDetailsEvent{
  final int id;

  GetProjectById(this.id);
}

final class EditProjectById extends ProjectDetailsEvent{
  final CreateProjectParams params;

  EditProjectById(this.params);
}


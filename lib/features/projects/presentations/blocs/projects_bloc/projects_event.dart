part of 'projects_bloc.dart';

sealed class ProjectsEvent {}

final class GetAllProjects extends ProjectsEvent{
  ProjectParams params;

  GetAllProjects(this.params);
}

final class CreateProject extends ProjectsEvent{
  final CreateProjectParams params;

  CreateProject(this.params);
}

final class UpdateProjectLocally extends ProjectsEvent{
  final ProjectEntity project;

  UpdateProjectLocally(this.project);
}


final class DeleteProject extends ProjectsEvent{
  final int id;

  DeleteProject(this.id);
}


final class SelectToDelete extends ProjectsEvent{
  final int id;

  SelectToDelete(this.id);
}




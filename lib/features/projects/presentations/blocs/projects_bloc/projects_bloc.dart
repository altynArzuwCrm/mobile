import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/delete_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'projects_event.dart';

part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetAllProjectsUseCase _allProjectsUseCase = GetAllProjectsUseCase(
    repository: locator(),
  );

  final CreateProjectUseCase _createProjectUseCase = CreateProjectUseCase(
    repository: locator(),
  );

  final DeleteProjectUseCase _deleteProjectUseCase = DeleteProjectUseCase(
    repository: locator(),
  );

  final NetworkInfo _networkInfo;

  ProjectsBloc(this._networkInfo) : super(ProjectsLoading()) {
    on<GetAllProjects>(_onGetAllProjects);
    on<CreateProject>(_onCreateProject);
    on<DeleteProject>(_onDeleteProject);
  }

  bool canLoad = true;
  List<ProjectEntity> _projects = [];
  List<int> selectedToRemove = [];

  Future<void> _onGetAllProjects(
    GetAllProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _projects.isNotEmpty) {
      canLoad = false;
      return;
    } else if (hasInternet) {
      canLoad = true;
    }

    final result = await _allProjectsUseCase.execute(event.params);
    result.fold(
      (failure) {
        if (failure is ConnectionFailure) {
          emit(ProjectsConnectionError());
        }
        if (failure is ServerFailure) {
          emit(ProjectsError());
        }
      },
      (data) {
        canLoad = data.isNotEmpty;
        if (event.params.page == 1) {
          _projects = data;
        } else {
          _projects.addAll(data);
        }

        emit(ProjectsLoaded(_projects));
      },
    );
  }

  Future<void> _onCreateProject(
    CreateProject event,
    Emitter<ProjectsState> emit,
  ) async {
    final result = await _createProjectUseCase.execute(event.params);

    result.fold(
      (failure) {
        if (failure is ConnectionFailure) {
          emit(ProjectsConnectionError());
        }
        if (failure is ServerFailure) {
          emit(ProjectsError());
        }
      },
      (data) {
        //emit(ProjectsLoaded(_projects));
        _projects.insert(0, data);
      },
    );
  }

  Future<void> _onDeleteProject(
      DeleteProject event,
      Emitter<ProjectsState> emit,
      ) async {
    final result = await _deleteProjectUseCase.execute(event.id);

    result.fold((failure) {
    }, (data) {
      if (data) {
        final updatedProjects = List<ProjectEntity>.from(_projects)
          ..removeWhere((e) => e.id == event.id);

        _projects = updatedProjects;
        emit(ProjectsLoaded(updatedProjects));
      }
    });
  }

}

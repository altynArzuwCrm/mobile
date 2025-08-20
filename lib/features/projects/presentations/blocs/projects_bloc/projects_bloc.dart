import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/delete_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/locator.dart';
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
    on<UpdateProjectLocally>(_updateProjectLocally);
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
          final existingIds = _projects.map((c) => c.id).toSet();
          final newItems = data
              .where((c) => !existingIds.contains(c.id))
              .toList();
          _projects.addAll(newItems);
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
        _projects.insert(0, data);
        emit(ProjectsLoaded(List<ProjectEntity>.from(_projects)));
      },
    );
  }

  Future<void> _onDeleteProject(
    DeleteProject event,
    Emitter<ProjectsState> emit,
  ) async {
    final result = await _deleteProjectUseCase.execute(event.id);

    result.fold((failure) {}, (data) {
      if (data) {
        final updatedProjects = List<ProjectEntity>.from(_projects)
          ..removeWhere((e) => e.id == event.id);

        _projects = updatedProjects;
        emit(ProjectsLoaded(updatedProjects));
      }
    });
  }

  void _updateProjectLocally(
    UpdateProjectLocally event,
    Emitter<ProjectsState> emit,
  ) {
    final index = _projects.indexWhere((u) => u.id == event.project.id);
    if (index != -1) {
      _projects[index] = event.project;
      emit(ProjectsLoaded(List<ProjectEntity>.from(_projects)));
    }
  }
}

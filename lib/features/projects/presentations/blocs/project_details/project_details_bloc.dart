import 'package:crm/core/error/failure.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/get_project_by_id.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectByIdUseCase _byIdUseCase = GetProjectByIdUseCase(
    repository: locator(),
  );

  ProjectDetailsBloc() : super(ProjectDetailLoading()) {
    on<GetProjectById>(_onGetProjectDetail);
  }

  Future<void> _onGetProjectDetail(
    GetProjectById event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailLoading());
    final result = await _byIdUseCase.execute(event.id);
    result.fold(
      (failure) {
        if (failure is ConnectionFailure) {
          emit(ProjectDetailConnectionError());
        }
        if (failure is ServerFailure) {
          emit(ProjectDetailError());
        }
      },
      (data) {
        emit(ProjectDetailLoaded(data));
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/locator.dart';
import 'package:meta/meta.dart';

part 'search_project_state.dart';

class SearchProjectCubit extends Cubit<SearchProjectState> {
  SearchProjectCubit() : super(SearchProjectInitial());
  final GetAllProjectsUseCase _allProjectsUseCase = GetAllProjectsUseCase(
    repository: locator(),
  );
  void initializeSearch(){
    emit(SearchProjectInitial());
  }

  Future<void> searchProjects(ProjectParams params) async {
    emit(SearchProjectLoading());

    final result = await _allProjectsUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(SearchProjectsConnectionError());
        } else {
          emit(SearchProjectsError());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchNotFoundedProjects());
        } else {
          emit(SearchFoundedProjects(data));
        }
      },
    );
  }
}

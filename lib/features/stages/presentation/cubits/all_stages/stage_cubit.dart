import 'package:crm/features/stages/data/repositories/stage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';

part 'stage_state.dart';

class StageCubit extends Cubit<StageState> {
  StageCubit(this.repository) : super(StageLoading());

  final StageRepository repository;

  Future<void> getAllStages() async {
    emit(StageLoading());

    final result = await repository.getAllStages();

    result.fold(
      (error) {
        emit(StageError());
      },
      (data) {
        emit(StageLoaded(data));
      },
    );
  }

  void selectCategory(String? value) {
    if (state is StageLoaded) {
      final current = state as StageLoaded;
      emit(current.copyWith(selectedCategory: value));
    }
  }
}

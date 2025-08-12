import 'package:bloc/bloc.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:crm/features/stages/data/repositories/stage_repository.dart';
import 'package:meta/meta.dart';

part 'stage_state.dart';

class StageCubit extends Cubit<StageState> {
  StageCubit(this.repository) : super(StageLoading());

  final StageRepository repository;

  Future<void> getAllStages() async {
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
}

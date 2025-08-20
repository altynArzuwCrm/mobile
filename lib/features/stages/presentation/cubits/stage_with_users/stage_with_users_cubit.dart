import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:crm/features/stages/data/repositories/stage_repository.dart';
import 'package:crm/features/users/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stage_with_users_state.dart';

class StageWithUsersCubit extends Cubit<StageWithUsersState> {
  StageWithUsersCubit(this.repository) : super(StageWithUsersLoading());
  final StageRepository repository;

  Future<void> getStagesWithUsers() async {
    emit(StageWithUsersLoading());

    final result = await repository.getAllUsersByStageRoles();

    result.fold(
      (error) {
        emit(StageWithUsersError(error.message));
      },
      (data) {
        emit(StageWithUsersLoaded(data));
      },
    );
  }
}

import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/usecases/edit_user_usecase.dart';
import 'package:crm/features/users/domain/usecases/get_current_user_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoading());

  final GetCurrentUserUseCase _currentUserUseCase = GetCurrentUserUseCase(
    repository: locator(),
  );
  final EditUserUseCase _editUserUseCase = EditUserUseCase(
    repository: locator(),
  );



  Future<void> getCurrentUser() async {
    final result = await _currentUserUseCase.execute(NoParams());

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(UserConnectionError());
        } else {
          emit(UserError());
        }
      },
      (right) {
        emit(UserLoaded(right));
      },
    );
  }

  Future<void> editUser(CreateUserParams params) async {
    emit(UserLoading());
    final result = await _editUserUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(UserConnectionError());
        } else {
          emit(UserError());
        }
      },
      (right) {
        emit(UserLoaded(right));
      },
    );
  }

}

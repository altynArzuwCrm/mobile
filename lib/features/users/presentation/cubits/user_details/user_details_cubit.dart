
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/usecases/edit_user_usecase.dart';
import 'package:crm/features/users/domain/usecases/get_user_by_id_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsLoading());

  final GetUserByIdUseCase _getUserDetails = GetUserByIdUseCase(
    repository: locator(),
  );

  final EditUserUseCase _editUserUseCase = EditUserUseCase(repository: locator());

  Future<void> getUserDetails(int id) async {
    emit(UserDetailsLoading());

    final result = await _getUserDetails.execute(id);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(UserDetailsConnectionError());
        } else {
          emit(UserDetailsError());
        }
      },
      (right) {
        emit(UserDetailsLoaded(right));
      },
    );
  }

  Future<void> editUser(CreateUserParams params ) async {
    emit(UserDetailsLoading());
    final result = await _editUserUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(UserDetailsConnectionError());
        } else {
          emit(UserDetailsError());
        }
      },
      (right) {
        emit(UserDetailsLoaded(right));
      },
    );
  }
}

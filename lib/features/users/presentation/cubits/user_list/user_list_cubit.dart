import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:crm/features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit(this._networkInfo) : super(UserListLoading());

  final GetAllUsersUseCase _allUsersUseCase = GetAllUsersUseCase(
    repository: locator(),
  );

  final DeleteUserUseCase _deleteUserUseCase = DeleteUserUseCase(
    repository: locator(),
  );

  final NetworkInfo _networkInfo;

  // bool canLoad = true;
  // List<UserEntity> _users = [];

  Future<void> getAllUsers(UserParams params) async {
    // final bool hasInternet = await _networkInfo.isConnected;
    //
    // if (!hasInternet && _users.isNotEmpty) {
    //   canLoad = false;
    //   return;
    // } else if (hasInternet) {
    //   canLoad = true;
    // }

    final result = await _allUsersUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(UserListConnectionError());
        } else {
          emit(UserListError());
        }
      },
      (data) {
        // canLoad = data.isNotEmpty;
        // if (params.page == 1) {
        //   _users = data;
        // } else {
        //   _users.addAll(data);
        // }
        emit(UserListLoaded(data));
      },
    );
  }

  Future<void> deleteUser(int id) async {
    final result = await _deleteUserUseCase.execute(id);

    result.fold((error) {}, (data) {
      if (data.isNotEmpty) {
        emit(UserListLoaded(data));
      }
    });
  }
}

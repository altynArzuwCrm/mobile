import 'package:crm/core/error/failure.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  SearchUserCubit() : super(SearchUserInitial());

  final GetAllUsersUseCase _allUsersUseCase = GetAllUsersUseCase(
    repository: locator(),
  );

 final List<UserEntity> _users = [];

  void initializeSearch() {
    emit(SearchUserInitial());
  }

  void searchUsers(UserParams params) async {
    _users.clear();
    emit(SearchUserLoading());

    final result = await _allUsersUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(SearchUserConnectionError());
        } else {
          emit(SearchUserError());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchNotFoundedUser());
        } else {
          emit(SearchFoundedUser(data));
        }
      },
    );
  }

  void deleteUser(int id){
    _users.removeWhere((e)=> e.id == id);
    emit(SearchFoundedUser(List.from(_users)));
  }


}

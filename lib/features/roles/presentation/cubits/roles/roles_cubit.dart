import 'package:bloc/bloc.dart';
import 'package:crm/features/roles/data/models/role_model.dart';
import 'package:crm/features/roles/data/repository/role_repository.dart';
import 'package:meta/meta.dart';

part 'roles_state.dart';

class RolesCubit extends Cubit<RolesState> {
  RolesCubit(this.repository) : super(RolesLoading());

  final RoleRepository repository;

  Future<void> getAllRoles({Set<int>? preselectedRoleIds}) async {
    final result = await repository.getAllRoles();

    result.fold((error) {}, (data) {
      emit(RolesLoaded(data,
        selectedRoleIds: preselectedRoleIds ?? {},));
    });
  }

  void toggleRoleSelection(int roleId) {
    if (state is RolesLoaded) {
      final currentState = state as RolesLoaded;
      final updatedSelection = Set<int>.from(currentState.selectedRoleIds);

      if (updatedSelection.contains(roleId)) {
        updatedSelection.remove(roleId);
      } else {
        updatedSelection.add(roleId);
      }

      emit(
        RolesLoaded(
          currentState.data,
          selectedRoleIds: updatedSelection,
        ),
      );

    }
  }
}

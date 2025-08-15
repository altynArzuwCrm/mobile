part of 'roles_cubit.dart';

sealed class RolesState {}

final class RolesLoading extends RolesState {}

final class RolesLoaded extends RolesState {
  final List<RoleModel> data;
  final Set<int> selectedRoleIds;

  RolesLoaded(this.data, {Set<int>? selectedRoleIds})
    : selectedRoleIds = selectedRoleIds ?? {};
}

final class RolesConnectionError extends RolesState {}

final class RolesError extends RolesState {}

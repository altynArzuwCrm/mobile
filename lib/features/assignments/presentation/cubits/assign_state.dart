part of 'assign_cubit.dart';


sealed class AssignState {}

final class AssignLoading extends AssignState {}
final class AssignLoaded extends AssignState {
  final AssignModel data;

  AssignLoaded(this.data);
}
final class AssignError extends AssignState {}

part of 'assign_cubit.dart';

abstract class AssignState {}

class AssignInitial extends AssignState {}

class AssignLoading extends AssignState {
  final int assignmentId;
  AssignLoading(this.assignmentId);
}

class AssignSuccess extends AssignState {
  final int assignmentId;
  final String message;
  AssignSuccess(this.assignmentId, this.message);
}

class AssignError extends AssignState {
  final int assignmentId;
  final String message;
  AssignError(this.assignmentId, this.message);
}

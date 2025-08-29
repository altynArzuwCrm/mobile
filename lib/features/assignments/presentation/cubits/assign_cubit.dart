import 'package:crm/features/assignments/data/repositories/assignment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assign_state.dart';

class AssignCubit extends Cubit<AssignState> {
  AssignCubit(this.repository) : super(AssignInitial());

  final AssignmentRepository repository;

  void updateOrderAssignmentStatus(int id, String status) async {
    if (isClosed) return;

    emit(AssignLoading(id));

    final result = await repository.updateOrderAssignmentStatus(id, status);

    if (isClosed) return;

    result.fold(
          (error) => emit(AssignError(id, error.message)),
          (data) => emit(AssignSuccess(id, data)),
    );
  }
}

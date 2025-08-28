import 'package:crm/features/assignments/data/models/assign_order_params.dart';
import 'package:crm/features/assignments/data/repositories/assignment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/features/assignments/data/models/assign_model.dart';

part 'assign_state.dart';

class AssignCubit extends Cubit<AssignState> {
  AssignCubit(this.repository) : super(AssignLoading());

  final AssignmentRepository repository;

  // void assignOrderToUser(AssignOrderParams params) async {
  //   final result = await repository.assignOrderToUser(params);
  //
  //   result.fold((error) {}, (data) {
  //     emit(data);
  //   });
  // }
  //
  // void bulkAssignOrders(BulkAssignOrderParams params) async {
  //   final result = await repository.bulkAssignOrders(params);
  //
  //   result.fold((error) {}, (data) {
  //     emit(data);
  //   });
  // }

  // void getAssignmentById(int id) async {
  //   final result = await repository.getOrderAssignmentById(id);
  //
  //   result.fold(
  //     (error) {
  //       emit(AssignError());
  //     },
  //     (data) {
  //       emit(AssignLoaded(data));
  //     },
  //   );
  // }
}

import 'package:crm/core/network/api_provider.dart';

abstract class AssignmentDataSources {
  Future<void> getOrderAssignments();

  Future<void> getOrderAssignmentById();

  Future<void> assignOrderToUser();

  Future<void> bulkAssignOrders();

  Future<void> updateOrderAssignmentStatus();

  Future<void> deleteOrderAssignment();

  Future<void> bulkAssignmentGlobal();

  Future<void> bulkReassignOrders();

  Future<void> bulkUpdateAssignments();
}

class AssignmentDataSourcesImpl extends AssignmentDataSources {
  final ApiProvider apiProvider;

  AssignmentDataSourcesImpl(this.apiProvider);

  @override
  Future<void> assignOrderToUser() async {
    // TODO: implement assignOrderToUser
    throw UnimplementedError();
  }

  @override
  Future<void> bulkAssignOrders() async {
    // TODO: implement bulkAssignOrders
    throw UnimplementedError();
  }

  @override
  Future<void> bulkAssignmentGlobal() async {
    // TODO: implement bulkAssignmentGlobal
    throw UnimplementedError();
  }

  @override
  Future<void> bulkReassignOrders() async {
    // TODO: implement bulkReassignOrders
    throw UnimplementedError();
  }

  @override
  Future<void> bulkUpdateAssignments() async {
    // TODO: implement bulkUpdateAssignments
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrderAssignment() async {
    // TODO: implement deleteOrderAssignment
    throw UnimplementedError();
  }

  @override
  Future<void> getOrderAssignmentById() async {
    // TODO: implement getOrderAssignmentById
    throw UnimplementedError();
  }

  @override
  Future<void> getOrderAssignments() async {
    // TODO: implement getOrderAssignments
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrderAssignmentStatus() async {
    // TODO: implement updateOrderAssignmentStatus
    throw UnimplementedError();
  }
}

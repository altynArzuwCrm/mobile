import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/assignments/data/models/assign_order_params.dart';

abstract class AssignmentDataSources {
  Future<void> getOrderAssignments();

  Future<void> getOrderAssignmentById();

  Future<bool> assignOrderToUser(AssignOrderParams params);

  Future<bool> bulkAssignOrders(BulkAssignOrderParams params);

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
  Future<bool> assignOrderToUser(AssignOrderParams params) async {
    final response = await apiProvider.post(
      endPoint: '${ApiEndpoints.orders}/${params.userId}/assign',
      data: params.toQueryParameters(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> bulkAssignOrders(BulkAssignOrderParams params) async {
    final response = await apiProvider.post(
      endPoint: '${ApiEndpoints.orders}/${params.id}/bulk-assign',
      data: params.toJson(),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
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

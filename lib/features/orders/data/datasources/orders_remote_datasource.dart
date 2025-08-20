import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/orders/data/models/comment_model.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getAllOrders(OrderParams params);

  Future<OrderModel> getOrderById(int id);

  Future<OrderModel> createOrder(CreateOrderParams params);

  Future<OrderModel> editOrder(CreateOrderParams params);

  Future<bool> deleteOrder(int id);

  Future<OrderModel> editOrderStage(String stage, int orderId);

  Future<bool> moveOrderToNextStage(CreateOrderParams params);

  Future<bool> getOrderStatusLogs(CreateOrderParams params);

  Future<List<CommentModel>> getOrderComments(int orderId);

  Future<List<CommentModel>> createOrderComment(CommentParams params);

  Future<List<CommentModel>> deleteOrderComment(int id, int orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiProvider apiProvider;

  OrderRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<OrderModel>> getAllOrders(OrderParams params) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.orders,
      query: params.toQueryParameters(),
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => OrderModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<OrderModel> getOrderById(int id) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.orders}/$id',
    );
    final result = response.data;
    return OrderModel.fromJson(result);
  }

  @override
  Future<OrderModel> createOrder(CreateOrderParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.orders,
      data: params.toQueryParameters(),
    );
    final result = response.data;

    return OrderModel.fromJson(result);
  }

  @override
  Future<OrderModel> editOrder(CreateOrderParams params) async {
    final response = await apiProvider.put(
      endPoint: '${ApiEndpoints.orders}/${params.id}',
      data: params.toQueryParameters(),
    );
    final result = response.data;
    return OrderModel.fromJson(result);
  }

  @override
  Future<bool> deleteOrder(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.orders}/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<OrderModel> editOrderStage(String stage, int orderId) async {
    final response = await apiProvider.put(
      endPoint: '${ApiEndpoints.orders}/$orderId/stage',
      data: {'stage': stage},
    );

    final result = response.data['order'];
    return OrderModel.fromJson(result);
  }

  @override
  Future<bool> moveOrderToNextStage(CreateOrderParams params) async {
    final response = await apiProvider.put(
      endPoint: ApiEndpoints.orders,
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<CommentModel>> getOrderComments(int orderId) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.comments,
      query: {"order_id": orderId},
    );

    final responseBody = response.data as List;

    final result = responseBody.map((e) => CommentModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<bool> getOrderStatusLogs(CreateOrderParams params) async {
    // TODO: implement getOrderStatusLogs
    throw UnimplementedError();
  }

  @override
  Future<List<CommentModel>> createOrderComment(CommentParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.comments,
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 201) {
      final comments = await getOrderComments(params.orderId);
      return comments;
    } else {
      return [];
    }
  }

  @override
  Future<List<CommentModel>> deleteOrderComment(int id, int orderId) async {
    final response = await apiProvider.post(
      endPoint: '${ApiEndpoints.comments}/$id',
      query: {"order_id": orderId},
    );

    if (response.statusCode == 204) {
      final comments = await getOrderComments(id);
      return comments;
    } else {
      return [];
    }
  }
}

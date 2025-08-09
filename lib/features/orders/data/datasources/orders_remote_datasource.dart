import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getAllOrders(CreateOrderParams params);

  Future<OrderModel> getOrderById(int id);

  Future<OrderModel> createOrder(CreateOrderParams params);

  Future<OrderModel> editOrder(CreateOrderParams params);

  Future<bool> deleteOrder(int id);

  Future<bool> editOrderStage(CreateOrderParams params);

  Future<bool> moveOrderToNextStage(CreateOrderParams params);

  Future<bool> getOrderStatusLogs(CreateOrderParams params);

  Future<bool> getOrderComments(CreateOrderParams params);

  Future<bool> postOrderComment(CreateOrderParams params);

  Future<bool> deleteOrderComment(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiProvider apiProvider;

  OrderRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<OrderModel>> getAllOrders(CreateOrderParams params) async {
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
    final result = response.data['data'];

    return OrderModel.fromJson(result);
  }

  @override
  Future<OrderModel> editOrder(CreateOrderParams params) async {
    final response = await apiProvider.put(
      endPoint: ApiEndpoints.orders,
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
  Future<bool> editOrderStage(CreateOrderParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.orders,
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
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
  Future<bool> deleteOrderComment(int id) async {
    // TODO: implement deleteOrderComment
    throw UnimplementedError();
  }

  @override
  Future<bool> getOrderComments(CreateOrderParams params) async {
    // TODO: implement getOrderComments
    throw UnimplementedError();
  }

  @override
  Future<bool> getOrderStatusLogs(CreateOrderParams params) async {
    // TODO: implement getOrderStatusLogs
    throw UnimplementedError();
  }

  @override
  Future<bool> postOrderComment(CreateOrderParams params) async {
    // TODO: implement postOrderComment
    throw UnimplementedError();
  }
}

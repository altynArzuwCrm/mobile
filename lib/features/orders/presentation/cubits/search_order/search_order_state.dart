part of 'search_order_cubit.dart';

sealed class SearchOrderState {}

final class SearchOrderInitial extends SearchOrderState {}

final class SearchOrderLoading extends SearchOrderState {}

final class SearchFoundedOrders extends SearchOrderState {
  final List<OrderModel> data;

  SearchFoundedOrders(this.data);
}

final class SearchNotFoundedOrders extends SearchOrderState {}

final class SearchOrdersConnectionError extends SearchOrderState {}

final class SearchOrdersError extends SearchOrderState {}

part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersLoading extends OrdersState {}
final class OrdersLoaded extends OrdersState {
  final List<OrderModel> data;

  OrdersLoaded(this.data);
}
final class OrdersConnectionError extends OrdersState {}
final class OrdersError extends OrdersState {}

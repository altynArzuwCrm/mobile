part of 'order_detail_cubit.dart';

@immutable
sealed class OrderDetailState {}

final class OrderDetailLoading extends OrderDetailState {}

final class OrderDetailLoaded extends OrderDetailState {
  final OrderModel data;

  OrderDetailLoaded(this.data);
}

final class OrderDetailConnectionError extends OrderDetailState {}

final class OrderDetailError extends OrderDetailState {}

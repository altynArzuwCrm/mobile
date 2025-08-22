part of 'order_stat_cubit.dart';

@immutable
sealed class OrderStatState {}

final class OrderStatLoading extends OrderStatState {}

final class OrderStatLoaded extends OrderStatState {
  final OrderStatModel data;

  OrderStatLoaded(this.data);
}

final class OrderStatError extends OrderStatState {}

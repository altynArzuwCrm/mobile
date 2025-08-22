part of 'revenue_stat_cubit.dart';

sealed class RevenueStatState {}

final class RevenueStatLoading extends RevenueStatState {}
final class RevenueStatLoaded extends RevenueStatState {
  final StatisticsModel data;

  RevenueStatLoaded(this.data);
}
final class RevenueStatError extends RevenueStatState {}

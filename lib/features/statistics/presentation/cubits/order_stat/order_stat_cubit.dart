import 'package:bloc/bloc.dart';
import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:crm/features/statistics/data/repository/statistics_repository.dart';
import 'package:meta/meta.dart';

part 'order_stat_state.dart';

class OrderStatCubit extends Cubit<OrderStatState> {
  OrderStatCubit(this.repository) : super(OrderStatLoading());

  final StatisticsRepository repository;

  void getOrderStats() async {
    final result = await repository.getUserStats();

    result.fold(
      (error) {
        emit(OrderStatError());
      },
      (data) {
        emit(OrderStatLoaded(data));
      },
    );
  }
}

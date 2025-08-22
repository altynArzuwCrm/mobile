import 'package:crm/features/statistics/data/models/statistics_model.dart';
import 'package:crm/features/statistics/data/repository/statistics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'revenue_stat_state.dart';

class RevenueStatCubit extends Cubit<RevenueStatState> {
  RevenueStatCubit(this.repository) : super(RevenueStatLoading());

  final StatisticsRepository repository;

  void getRevenue(int year) async {
    final result = await repository.getRevenue(year);

    result.fold(
      (error) {
        emit(RevenueStatError());
      },
      (data) {
        emit(RevenueStatLoaded(data));
      },
    );
  }
}

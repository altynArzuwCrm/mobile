import 'package:bloc/bloc.dart';
import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:crm/features/statistics/data/repository/statistics_repository.dart';
import 'package:meta/meta.dart';

part 'user_stat_state.dart';

class UserStatCubit extends Cubit<UserStatState> {
  UserStatCubit(this.repository) : super(UserStatLoading());


  final StatisticsRepository repository;

  void getUserStats() async {
    final result = await repository.getUserStats();

    result.fold(
          (error) {
        emit(UserStatError());
      },
          (data) {
        emit(UserStatLoaded(data));
      },
    );
  }

}

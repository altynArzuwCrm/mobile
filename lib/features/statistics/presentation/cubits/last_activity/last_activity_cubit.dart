import 'package:crm/features/statistics/data/models/last_activity_model.dart';
import 'package:crm/features/statistics/data/repository/statistics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'last_activity_state.dart';

class LastActivityCubit extends Cubit<LastActivityState> {
  LastActivityCubit(this.repository) : super(LastActivityLoading());

  final StatisticsRepository repository;

  void getLastActivity() async {
    final result = await repository.getLastActivities();

    result.fold(
      (error) {
        emit(LastActivityError());
      },
      (data) {
        emit(LastActivityLoaded(data));
      },
    );
  }
}

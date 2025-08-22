import 'package:crm/features/statistics/data/models/activity_model.dart';
import 'package:crm/features/statistics/data/repository/statistics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_activity_state.dart';

class AllActivityCubit extends Cubit<AllActivityState> {
  AllActivityCubit(this.repository) : super(AllActivityLoading());

  final StatisticsRepository repository;

  void getAllActivities() async {
    final result = await repository.getAllActivity();

    result.fold(
      (error) {
        emit(AllActivityError());
      },
      (data) {
        emit(AllActivityLoaded(data));
      },
    );
  }
}

import 'package:crm/core/error/failure.dart';
import 'package:crm/features/notifications/data/models/notificaton_model.dart';
import 'package:crm/features/notifications/data/repository/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(NotificationLoading());

  final NotificationRepository repository;

  Future<void> getAllNotifications() async {
    final result = await repository.getAllNotifications();

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(NotificationConnectionError());
        } else {
          emit(NotificationError());
        }
      },
      (data) {
        emit(NotificationLoaded(data));
      },
    );
  }
}

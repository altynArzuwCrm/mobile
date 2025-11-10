import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/notifications/data/models/notificaton_model.dart';
import 'package:crm/features/notifications/data/repository/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository, this._networkInfo) : super(NotificationLoading());

  final NotificationRepository repository;
  final NetworkInfo _networkInfo;

  List<NotificationModel> _notifications = [];
  bool canLoad = true;

  Future<void> getAllNotifications(int page) async {
    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _notifications.isNotEmpty) {
      canLoad = false;
      // return;
    } else if (hasInternet) {
      canLoad = true;
    }

    final result = await repository.getAllNotifications(page);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(NotificationConnectionError());
        } else {
          emit(NotificationError());
        }
      },
      (data) {
       // _notifications = data;
        if (page == 1) {
          _notifications = data;
        } else {
          final existingIds = _notifications.map((c) => c.assignedAt).toSet();
          final newItems = data
              .where((c) => !existingIds.contains(c.assignedAt))
              .toList();

          _notifications.addAll(newItems);
        }

        canLoad = data.isNotEmpty;
        emit(NotificationLoaded(_notifications));
      },
    );
  }
}

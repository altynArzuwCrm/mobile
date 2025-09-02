import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/notifications/presentation/cubits/notifications/notification_cubit.dart';
import 'package:crm/features/notifications/presentation/widgets/notification_item_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationCubit = locator<NotificationCubit>();

  @override
  void initState() {
    super.initState();
    notificationCubit.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.notifications)),

      body: BlocProvider.value(
        value: notificationCubit,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              final data = state.data;
              return ListView.separated(
                itemCount: data.length,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 65),
                itemBuilder: (context, index) {
                  final item = data[index];
                  return NotificationItemWidget(
                    title: item.actionUserName,
                    text: item.message,
                    time: item.assignedAt,
                    orderId: item.orderId,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            } else if (state is NotificationConnectionError) {
              return Center(child: Text(AppStrings.noInternet));
            } else {
              return Center(child: Text(AppStrings.error));
            }
          },
        ),
      ),
    );
  }
}

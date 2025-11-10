import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/notifications/presentation/cubits/notifications/notification_cubit.dart';
import 'package:crm/features/notifications/presentation/widgets/notification_item_widget.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationCubit = locator<NotificationCubit>();
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    notificationCubit.getAllNotifications(_currentPage);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;

    notificationCubit.getAllNotifications(_currentPage);
  }

  void _onLoad() async {
    if (notificationCubit.canLoad) {
      _currentPage++;

      notificationCubit.getAllNotifications(_currentPage);
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.notifications)),

      body: BlocProvider.value(
        value: notificationCubit,
        child: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationLoaded) {
              _refreshController.refreshCompleted();
              if (notificationCubit.canLoad) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
            } else if (state is NotificationConnectionError) {
              _refreshController.refreshFailed();
              _refreshController.loadFailed();
            }
          },
          builder: (context, state) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: notificationCubit.canLoad,
              footer: const KFooter(),
              onRefresh: _onRefresh,
              onLoading: _onLoad,
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(NotificationState state) {
    if (state is NotificationLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is NotificationLoaded) {

      final userState = locator<UserCubit>().state;
      String name = '';
      if(userState  is UserLoaded){
        name =  userState.data.name;
      }

      final data = state.data;
      return ListView.separated(
        itemCount: data.length,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 65),
        itemBuilder: (context, index) {
          final item = data[index];
          return NotificationItemWidget(
            title: name,
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
      return Center(child: Text(AppStrings.noInternet,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
    } else {
      return Center(child: Text(AppStrings.error,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
    }
  }

}

import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/widgets/user_card.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserList extends StatefulWidget {
  const UserList({super.key, required this.sortOrder});
  final String sortOrder;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList>  with AutomaticKeepAliveClientMixin {
  final UserListCubit _userListCubit = locator<UserListCubit>();
  int _currentPage = 1;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _userListCubit.getAllUsers(UserParams());
  }


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;
    _userListCubit.getAllUsers(UserParams(page: _currentPage, sortOrder: widget.sortOrder));
    _refreshController.refreshCompleted();
  }

  void _onLoad() async {
    if (_userListCubit.canLoad) {
      _currentPage++;
      _userListCubit.getAllUsers(UserParams(page: _currentPage, sortOrder: widget.sortOrder));
    }else{
      _refreshController.loadNoData();
    }
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetDisConnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.noInternet),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
              ),
              backgroundColor: Colors.red,
              duration: Duration(minutes: 5),
            ),
          );
        } else if (state is InternetConnected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: BlocConsumer<UserListCubit, UserListState>(
        listener: (context, state) {
          // Finish indicators AFTER data state arrives
          if (state is UserListLoaded) {
            _refreshController.refreshCompleted();
            if (_userListCubit.canLoad) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadNoData();
            }
          } else if (state is UserListConnectionError) {
            _refreshController.refreshFailed();
            _refreshController.loadFailed();
          }
        },
        builder: (context, state) {
         return SmartRefresher(
           controller: _refreshController,
           enablePullDown: true,
           enablePullUp: _userListCubit.canLoad,
           header: const WaterDropHeader(),
           footer: const KFooter(),
           onRefresh: _onRefresh,
           onLoading: _onLoad,
           child: _buildBody(state),
         );
        },
      ),
    );
  }

  Widget _buildBody(UserListState state){
    if (state is UserListLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is UserListLoaded) {
      final data = state.data;
      return ListView.separated(
        itemCount: data.length,
        padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
        itemBuilder: (context, index) {
          final item = data[index];
          return UserCard(
            data: item,
            onDelete: () {
              locator<UserListCubit>().deleteUser(item.id);
            },
            onTap: () {
              context.push(AppRoutes.userDetails, extra: {'user': item});
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
      );
    } else if (state is UserListConnectionError) {
      return Center(child: Text(AppStrings.noInternet));
    } else {
      return Center(child: Text(AppStrings.error));
    }
  }

}

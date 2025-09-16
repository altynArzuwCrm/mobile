import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/common/widgets/sort_order_button.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/features/users/presentation/widgets/user_card.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

//correct pagination

class _UserPageState extends State<UserPage> {
  String sortOrder = "asc";

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
    _userListCubit.getAllUsers(
      UserParams(page: _currentPage, sortOrder: sortOrder),
    );
  }

  void _onLoad() async {
    if (_userListCubit.canLoad) {
      _currentPage++;
      _userListCubit.getAllUsers(
        UserParams(page: _currentPage, sortOrder: sortOrder),
      );
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.members),
        actions: [
          SortOrderSelector(
            sortOrder: sortOrder,
            isIconOnly: true,
            onChanged: (val) {
              setState(() {
                sortOrder = val;
                _currentPage = 1;
              });

              locator<UserListCubit>().getAllUsers(
                UserParams(page: _currentPage, sortOrder: sortOrder),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 10),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.searchUsers);
              },
              icon: IconAssets.search,
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserListCubit, UserListState>(
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
            footer: const KFooter(),
            onRefresh: _onRefresh,
            onLoading: _onLoad,
            child: _buildBody(state),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.addUser);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(UserListState state) {
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
      return Center(child: Text(AppStrings.noInternet,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
    } else {
      return Center(child: Text(AppStrings.error,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
    }
  }
}

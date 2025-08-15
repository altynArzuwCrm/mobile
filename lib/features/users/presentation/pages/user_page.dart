import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/pages/components/filter_widget.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:crm/features/users/presentation/pages/components/user_activity_list.dart';
import 'package:crm/features/users/presentation/pages/components/user_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/add_user_page.dart';
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final UserListCubit _userListCubit = locator<UserListCubit>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    // _userListCubit.getAllUsers(UserParams());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.members),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(onTap: _openSort, icon: IconAssets.filter),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: TabBarHeader(
            tabController: _tabController,
            tabs: [
              Tab(child: Center(child: Text(AppStrings.members, maxLines: 1))),
              Tab(child: Center(child: Text(AppStrings.activity, maxLines: 1))),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [const UserList(), UserActivityList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          context.push(AppRoutes.addUser);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _openSort() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return FilterWidget();
      },
    );
  }
}

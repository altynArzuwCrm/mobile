import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/pages/components/contacts.dart';
import 'package:crm/features/orders/presentation/components/filter_widget.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ClientsCubit _clientsCubit = locator<ClientsCubit>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _clientsCubit.getAllClients(UserParams());
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
        title: Text(AppStrings.contacts),
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
              Tab(child: Center(child: Text(AppStrings.contacts, maxLines: 1))),
              Tab(
                child: Center(child: Text(AppStrings.companies, maxLines: 1)),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ContactsList(), ContactsList()],
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

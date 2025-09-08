import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/clients/presentation/cubits/companies/company_cubit.dart';
import 'package:crm/features/clients/presentation/pages/components/contacts_list.dart';
import 'package:crm/features/clients/presentation/pages/filter_client_widget.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/add_client_widget.dart';
import 'components/company_list.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    locator<CompanyCubit>().getCompanies();
    orderBy = null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String sortOrder = "asc";
  String? orderBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.customers),
        actions: [
          AppBarIcon(onTap: _openSort, icon: IconAssets.filter),

          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 10),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.searchClients);
              },
              icon: IconAssets.search,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: TabBarHeader(
            tabController: _tabController,
            tabs: [
              Tab(child: Center(child: Text(AppStrings.customers, maxLines: 1))),
              Tab(
                child: Center(child: Text(AppStrings.companies, maxLines: 1)),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ContactsList(sortOrder: sortOrder),
          CompanyList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddUser,
        child: Icon(Icons.add),
      ),
    );
  }

  void _openSort() async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return FilterClientWidget(initialSortOrder: sortOrder, sortBy: orderBy);
      },
    );

    if (result != null) {
      setState(() {
        sortOrder = result;
      });
    }
  }

  void _openAddUser() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddClientWidget();
      },
    );
  }
}

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/add_order_widget.dart';
import 'package:crm/features/orders/presentation/widgets/filter_widget.dart';
import 'package:crm/features/settings/presentation/pages/contacts/components/contacts.dart';
import 'package:crm/features/settings/presentation/widgets/project_card.dart';
import 'package:crm/features/settings/presentation/widgets/tabbar_btn.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>   with SingleTickerProviderStateMixin  {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: 0);

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
        title: Text('Контакты'),
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
              Tab(
                child: Center(
                    child: Text('Контакты',
                        maxLines: 1)),
              ),
              Tab(
                child: Center(
                    child: Text('Компании',
                        maxLines: 1)),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Contacts(),
          Contacts(),

        ],
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

  void _openAddOrder() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddOrderWidget();
      },
    );
  }
}

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/main/presentation/widgets/user_item_widget.dart';
import 'package:crm/features/orders/presentation/widgets/add_order_widget.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_widget.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/filter_widget.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/type_chip.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:crm/features/settings/presentation/widgets/project_card.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.projects),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(onTap: _openSort, icon: IconAssets.filter),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.separated(
            itemCount: 15,
            padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
            itemBuilder: (context, index) {
              return ProjectCard();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
          ),
          Positioned(
            right: 15,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: _openAddOrder,
              child: Icon(Icons.add),
            ),
          ),

          Positioned(
            right: 25,
            bottom: 15,
            left: 15,
            child: MainButton(
              buttonTile: 'Вернуться',
              onPressed: () {},
              isLoading: false,
            ),
          ),
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

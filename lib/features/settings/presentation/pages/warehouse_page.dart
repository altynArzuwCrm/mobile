import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/components/add_order_widget.dart';
import 'package:crm/features/orders/presentation/components/filter_widget.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({super.key});

  @override
  State<WareHousePage> createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.products),
        actions: [
          AppBarIcon(onTap: () {}, icon: IconAssets.delete),
          SizedBox(width: 7),
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
            padding: EdgeInsets.fromLTRB(15, 15, 15, 65),
            itemBuilder: (context, index) {
              return ProductItemWidget();
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

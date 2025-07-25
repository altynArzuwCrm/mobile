import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/add_order_widget.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_widget.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/filter_widget.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/type_chip.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders),
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
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoryBtn(
                          title: 'Vse $index',
                          isSelected: index == 0,
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TypeChip(
                          title: 'В работе ',
                          isSelected: false,
                          onTap: () {},
                        ),
                        SizedBox(width: 8),
                        TypeChip(
                          title: 'Просрочено ',
                          isSelected: true,
                          onTap: () {},
                        ),
                        SizedBox(width: 8),
                        TypeChip(
                          title: 'В ожидании ',
                          isSelected: false,
                          onTap: () {},
                        ),
                        SizedBox(width: 8),
                        TypeChip(
                          title: 'Завершено ',
                          isSelected: false,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   itemCount: 20,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(right: 8.0),
                  //       child: TypeChip(
                  //         title: 'Vse $index',
                  //         isSelected: index == 0, onTap: () {  },
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return OrderCard();
                  },
                  childCount: 10, // Set the number of children here
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 70)),
            ],
          ),
          Positioned(
              right: 15,
              bottom: 100,
              child: FloatingActionButton(onPressed: _openAddOrder,child: Icon(Icons.add),)),
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

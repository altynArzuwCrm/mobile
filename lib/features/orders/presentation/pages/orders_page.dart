import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/components/add_order_widget.dart';
import 'package:crm/features/orders/presentation/components/filter_widget.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/type_chip.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int isSelected = 0;
  int isSelected2 = 1;
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders),
        actions: [
          selectedIndices.isNotEmpty ?
          AppBarIcon(onTap: () {}, icon: IconAssets.delete)

          : SizedBox.shrink()
          ,
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
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: AppStrings.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoryBtn(
                          title: AppStrings.categories[index],
                          isSelected: index == isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: AppStrings.categories2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TypeChip(
                          title: AppStrings.categories2[index],
                          isSelected: isSelected2 == index,
                          onTap: () {
                            setState(() {
                              isSelected2 = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {

                  final isSelectedItem = selectedIndices.contains(index);
                  final hasAnySelected = selectedIndices.isNotEmpty;


                  return OrderCard(
                    isSelected: isSelectedItem,
                    hasSelected: hasAnySelected,
                    onTap: () {
                      setState(() {
                        // If already selected, deselect. Else, select.
                        if (hasAnySelected) {
                          if (isSelectedItem) {
                            selectedIndices.remove(index);
                          } else {
                            selectedIndices.add(index);
                          }
                        }
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        selectedIndices.add(index);
                      });
                    },
                  );

                }, childCount: 10),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 70)),
            ],
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

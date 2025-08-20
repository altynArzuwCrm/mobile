import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/models/status_model.dart';
import 'package:crm/features/orders/presentation/cubits/order_stage/order_stage_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/type_chip.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'components/filter_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int isStageSelected = 0;
  int isStatusSelected = 0;
  String? selectedStage;
  String? selectedStatus;

  final Set<int> selectedIndices = {};
  final stageCubit = locator<StageCubit>();
  final ordersCubit = locator<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    stageCubit.getAllStages();
    ordersCubit.getAllOrders(OrderParams());
    locator<UserCubit>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders),
        actions: [
          selectedIndices.isNotEmpty
              ? AppBarIcon(onTap: () {}, icon: IconAssets.delete)
              : SizedBox.shrink(),
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
                child: BlocBuilder<StageCubit, StageState>(
                  builder: (context, state) {
                    if (state is StageLoading) {
                      return SizedBox(height: 40);
                    } else if (state is StageLoaded) {
                      final data = state.data;
                      return SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: data.length,
                          itemBuilder: (context, index) {

                            if (index == 0) {
                              // First static item
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CategoryBtn(
                                  title: "Все",
                                  isSelected: isStageSelected == 0,
                                  onTap: () {
                                    setState(() {
                                      isStageSelected = 0;
                                      selectedStage = null; // or any default value you use
                                    });
                                    ordersCubit.getAllOrders(
                                      OrderParams(
                                        stage: selectedStage,
                                        status: selectedStatus,
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              final item = data[index - 1];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CategoryBtn(
                                  title: item.displayName,
                                  isSelected: index == isStageSelected,
                                  onTap: () {
                                    setState(() {
                                      isStageSelected = index;
                                      selectedStage = item.name;
                                    });
                                    ordersCubit.getAllOrders(
                                      OrderParams(
                                        stage: selectedStage,
                                        status: selectedStatus,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: StatusModel.statuses.length,
                    itemBuilder: (context, index) {
                      final item = StatusModel.statuses[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TypeChip(
                          title: item.name,
                          isSelected: isStatusSelected == index,
                          onTap: () {
                            setState(() {
                              isStatusSelected = index;
                              selectedStatus = item.status;
                            });

                            ordersCubit.getAllOrders(
                              OrderParams(
                                stage: selectedStage,
                                status: selectedStatus,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is OrdersLoaded) {
                    final data = state.data;
                    return BlocProvider(
                      create: (context) => OrderStageSelectionCubit(),
                      child: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final isSelectedItem = selectedIndices.contains(
                            index,
                          );
                          final hasAnySelected = selectedIndices.isNotEmpty;
                          final item = data[index];

                          return OrderCard(
                            isSelected: isSelectedItem,
                            hasSelected: hasAnySelected,
                            model: item,
                            onTap: () {
                              setState(() {
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
                        }, childCount: data.length),
                      ),
                    );
                  } else if (state is OrdersConnectionError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(AppStrings.noInternet)),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(AppStrings.error)),
                    );
                  }
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 70)),
            ],
          ),
          Positioned(
            right: 15,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: (){
                context.push(AppRoutes.addOrder);
              },
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

}

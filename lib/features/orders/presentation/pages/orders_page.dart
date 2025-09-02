import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/assignments/presentation/cubits/assign_cubit.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/models/status_model.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/type_chip.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'filter_order_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int isStatusSelected = 0;
  String? selectedStatus;
  String sortOrder = "asc";
  String? orderBy;

  String? selectedStage;
  int _currentPage = 1;

  final stageCubit = locator<StageCubit>();
  final ordersCubit = locator<OrdersCubit>();
  final assignCubit = locator<AssignCubit>();

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    stageCubit.getAllStages();
    ordersCubit.getAllOrders(OrderParams(page: _currentPage));
    locator<UserCubit>().getCurrentUser();
    orderBy = null;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;

    ordersCubit.getAllOrders(OrderParams(page: _currentPage));
  }

  void _onLoad() async {
    if (ordersCubit.canLoad) {
      _currentPage++;

      ordersCubit.getAllOrders(OrderParams(page: _currentPage));
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders),
        actions: [
          AppBarIcon(onTap: _openSort, icon: IconAssets.filter),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 10),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.searchOrders);
              },
              icon: IconAssets.search,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
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
                                page: _currentPage,
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

                const SizedBox(height: 20),

                Expanded(
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                    listener: (context, state) {
                      if (state is OrdersLoaded) {
                        _refreshController.refreshCompleted();
                        if (ordersCubit.canLoad) {
                          _refreshController.loadComplete();
                        } else {
                          _refreshController.loadNoData();
                        }
                      } else if (state is OrdersConnectionError) {
                        _refreshController.refreshFailed();
                        _refreshController.loadFailed();
                      }
                    },
                    builder: (context, state) {
                      return SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: ordersCubit.canLoad,
                        footer: const KFooter(),
                        onRefresh: _onRefresh,
                        onLoading: _onLoad,
                        child: _buildBody(state),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating button
          Positioned(
            right: 15,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: () => context.push(AppRoutes.addOrder),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(OrdersState state) {
    if (state is OrdersLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrdersLoaded) {
      final data = state.data;
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return OrderCard(model: item);
        },
      );
    } else if (state is OrdersConnectionError) {
      return const Center(child: Text(AppStrings.noInternet));
    } else {
      return const Center(child: Text(AppStrings.error));
    }
  }

  void _openSort() async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return FilterOrderWidget(
          selectedStatus: selectedStatus,
          initialSortOrder: sortOrder,
          orderBy: orderBy,
        );
      },
    );

    if (result != null) {
      setState(() {
        sortOrder = result;
      });
    }
  }
}

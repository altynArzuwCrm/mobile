import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/common/widgets/sort_order_button.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_product_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final productsCubit = locator<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    productsCubit.getAllProducts(ProductParams(page: _currentPage));
  }

  int _currentPage = 1;
  String sortOrder = "asc";

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;
    productsCubit.getAllProducts(
      ProductParams(page: _currentPage, sortProduct: sortOrder),
    );
    _refreshController.refreshCompleted();
  }

  void _onLoad() async {
    if (productsCubit.canLoad) {
      _currentPage++;
      await productsCubit.getAllProducts(
        ProductParams(page: _currentPage, sortProduct: sortOrder),
      );
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.products),
        actions: [
          SortOrderSelector(
            sortOrder: sortOrder,
            isIconOnly: true,
            onChanged: (val) {
              setState(() => sortOrder = val);
              debugPrint("Sort order: $sortOrder");

              setState(() {
                sortOrder = val;
                _currentPage = 1;
              });

              productsCubit.getAllProducts(
                ProductParams(page: _currentPage, sortProduct: sortOrder),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 10),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.searchProdcuts);
              },
              icon: IconAssets.search,
            ),
          ),
        ],
      ),
      body: BlocProvider.value(
        value: productsCubit,
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              final data = state.data;
              return Stack(
                children: [
                  SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: productsCubit.canLoad,
                    header: const WaterDropHeader(),
                    footer: const KFooter(),
                    onRefresh: _onRefresh,
                    onLoading: _onLoad,
                    child: ListView.separated(
                      itemCount: data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      itemBuilder: (context, index) {
                        final item = data[index];

                        return ProductItemWidget(
                          model: item,
                          onDelete: () {
                            productsCubit.deleteProduct(item.id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5);
                      },
                    ),
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
              );
            } else if (state is ProductsConnectionError) {
              return Center(child: Text(AppStrings.noInternet));
            } else {
              return Center(child: Text(AppStrings.error));
            }
          },
        ),
      ),
    );
  }

  void _openAddOrder() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddProductPage();
      },
    );
  }
}

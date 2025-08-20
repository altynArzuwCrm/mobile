import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/pages/add_order_page.dart';
import 'package:crm/features/orders/presentation/pages/components/filter_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({super.key});

  @override
  State<WareHousePage> createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {
  final productsCubit = locator<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    productsCubit.getAllProducts(ProductParams());
  }

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
                  ListView.separated(
                    itemCount: data.length,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return ProductItemWidget(title: item.name);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5);
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
        return AddOrderPage();
      },
    );
  }
}

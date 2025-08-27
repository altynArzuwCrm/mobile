import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/search_products/search_products_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/product_item_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsSearchPage extends StatefulWidget {
  const ProductsSearchPage({super.key});

  @override
  State<ProductsSearchPage> createState() => _ProductsSearchPageState();
}

class _ProductsSearchPageState extends State<ProductsSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final searchCubit = locator<SearchProductsCubit>();

  @override
  void dispose() {
    _searchCtrl.dispose();
    searchCubit.initializeSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.search),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 58), //56
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: HomePageSearchWidget(
              searchCtrl: _searchCtrl,
              onSearch: () {
                setState(() {});
                searchCubit.searchProducts(
                  ProductParams(search: _searchCtrl.text.trim()),
                );
              },
              onClear: () {
                setState(() {});
                _searchCtrl.clear();
                searchCubit.initializeSearch();
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ),
      ),
      body: BlocProvider.value(
        value: searchCubit,
        child: BlocBuilder<SearchProductsCubit, SearchProductsState>(
          builder: (context, state) {
            if (state is SearchProductsInitial) {
              return const Center(child: Text('Search clients'));
            } else if (state is SearchProductsLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchFoundedProducts) {
              final data = state.data;
              return ListView.separated(
                itemCount: data.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemBuilder: (context, index) {
                  final item = data[index];

                  return ProductItemWidget(
                    model: item,
                    onDelete: () {
                      locator<SearchProductsCubit>().deleteProduct(item.id);
                      searchCubit.deleteProduct(item.id);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
              );
            } else if (state is SearchNotFoundedProducts) {
              return Center(child: Text('Not founded'));
            } else if (state is SearchProductsConnectionError) {
              return Center(child: Text(AppStrings.noInternet));
            } else {
              return Center(child: Text(AppStrings.error));
            }
          },
        ),
      ),
    );
  }
}

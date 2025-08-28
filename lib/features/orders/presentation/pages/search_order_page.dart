import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/search_order/search_order_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersSearchPage extends StatefulWidget {
  const OrdersSearchPage({super.key});

  @override
  State<OrdersSearchPage> createState() => _OrdersSearchPageState();
}

class _OrdersSearchPageState extends State<OrdersSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final searchCubit = locator<SearchOrderCubit>();

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
                searchCubit.searchOrders(
                  OrderParams(search: _searchCtrl.text.trim()),
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
        child: BlocBuilder<SearchOrderCubit, SearchOrderState>(
          builder: (context, state) {
            if (state is SearchOrderInitial) {
              return const Center(child: Text('Search clients'));
            } else if (state is SearchOrderLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchFoundedOrders) {
              final data = state.data;

              return ListView.builder(
                itemCount: data.length,
                physics: const AlwaysScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  final item = data[index];
                  return OrderCard(
                    model: item,
                  );
                },
              );
            } else if (state is SearchNotFoundedOrders) {
              return Center(child: Text('Not founded'));
            } else if (state is SearchOrdersConnectionError) {
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

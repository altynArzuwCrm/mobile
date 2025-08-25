import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/cubits/search_client/search_client_cubit.dart';
import 'package:crm/features/clients/presentation/widgets/client_card.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientsSearchPage extends StatefulWidget {
  const ClientsSearchPage({super.key});

  @override
  State<ClientsSearchPage> createState() => _ClientsSearchPageState();
}

class _ClientsSearchPageState extends State<ClientsSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final searchCubit = locator<SearchClientCubit>();

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
                searchCubit.searchClients(
                  UserParams(search: _searchCtrl.text.trim()),
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
        child: BlocBuilder<SearchClientCubit, SearchClientState>(
          builder: (context, state) {
            if (state is SearchClientInitial) {
              return const Center(child: Text('Search clients'));
            } else if (state is SearchClientLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchFoundedClients) {
              final data = state.data;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 85),
                itemCount: data.length,
                physics: const AlwaysScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  final item = data[index];
                  return ClientCard(
                    data: item,
                    onDelete: () {
                      locator<ClientsCubit>().deleteClient(item.id);
                      searchCubit.deleteClient(item.id);
                    },
                    onTap: () {
                      context.push(
                        AppRoutes.clientDetails,
                        extra: {'client': item},
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 20),
              );
            } else if (state is SearchNotFoundedClients) {
              return Center(child: Text('Not founded'));
            } else if (state is SearchClientsConnectionError) {
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

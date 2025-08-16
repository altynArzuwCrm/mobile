import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/widgets/client_card.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> with AutomaticKeepAliveClientMixin {
  final ClientsCubit _clientsCubit = locator<ClientsCubit>();


  int _currentPage = 1;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _clientsCubit.getAllClients(UserParams());

  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;
    _clientsCubit.getAllClients(UserParams(page: _currentPage));
    _refreshController.refreshCompleted();
  }

  void _onLoad() async {
    if (_clientsCubit.canLoad) {
      _currentPage++;
      _clientsCubit.getAllClients(UserParams(page: _currentPage));
    }else{
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetDisConnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.noInternet),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
              ),
              backgroundColor: Colors.red,
              duration: Duration(minutes: 5),
            ),
          );
        } else if (state is InternetConnected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: BlocProvider.value(
        value: _clientsCubit,

        child: BlocConsumer<ClientsCubit, ClientsState>(
          listener: (context, state) {
            // Finish indicators AFTER data state arrives
            if (state is ClientsLoaded) {
              _refreshController.refreshCompleted();
              if (_clientsCubit.canLoad) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
            } else if (state is ClientsConnectionError) {
              _refreshController.refreshFailed();
              _refreshController.loadFailed();
            }
          },
          builder: (context, state) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: _clientsCubit.canLoad,
              header: const WaterDropHeader(),
              footer: const KFooter(),
              onRefresh: _onRefresh,
              onLoading: _onLoad,
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }
  Widget _buildBody(ClientsState state) {
    if (state is ClientsLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ClientsLoaded) {
      final data = state.data;
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 85),
        itemCount: data.length,
        physics: const AlwaysScrollableScrollPhysics(),

        itemBuilder: (context, index) {
          final item = data[index];
          return ClientCard(
            data: item,
            onDelete: () => _clientsCubit.deleteClient(item.id),
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
    }
    if (state is ClientsConnectionError) {
      return const Center(child: Text(AppStrings.noInternet));
    }
    return const Center(child: Text(AppStrings.error));
  }

  @override
  bool get wantKeepAlive => true;
}

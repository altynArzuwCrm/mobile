import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/cubits/search_user/search_user_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/features/users/presentation/widgets/user_card.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UsersSearchPage extends StatefulWidget {
  const UsersSearchPage({super.key});

  @override
  State<UsersSearchPage> createState() => _UsersSearchPageState();
}

class _UsersSearchPageState extends State<UsersSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final searchCubit = locator<SearchUserCubit>();

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
                searchCubit.searchUsers(
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
        child: BlocBuilder<SearchUserCubit, SearchUserState>(
          builder: (context, state) {
            if (state is SearchUserInitial) {
              return const Center(child: Text(AppStrings.searchUsers));
            } else if (state is SearchUserLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchFoundedUser) {
              final data = state.data;
              return ListView.separated(
                itemCount: data.length,
                padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
                itemBuilder: (context, index) {
                  final item = data[index];
                  return UserCard(
                    data: item,
                    onDelete: () {
                    locator<UserListCubit>().deleteUser(item.id);
                    searchCubit.deleteUser(item.id);
                    },
                    onTap: () {
                      context.push(AppRoutes.userDetails, extra: {'user': item});
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              );
            } else if (state is SearchNotFoundedUser) {
              return Center(child: Text(AppStrings.notFounded,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
            } else if (state is SearchUserConnectionError) {
              return Center(child: Text(AppStrings.noInternet,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
            } else {
              return Center(child: Text(AppStrings.error,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
            }
          },
        ),
      ),
    );
  }
}

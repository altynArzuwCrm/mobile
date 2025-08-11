import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/settings/presentation/widgets/contacts_card.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/features/users/presentation/pages/ui_model/user_ui_model.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            final data = state.data;
            return ListView.separated(
              itemCount: data.length,
              padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
              itemBuilder: (context, index) {
                final item = data[index];
                return ContactsCard(
                  data: UserListUiModel(
                    name: item.name,
                    job: item.roles?.first.displayName ??'',
                    email: '',
                    companyName: '',
                    phone: item.phone,
                  ),
                  onDelete: () {
                    locator<UserListCubit>().deleteUser(item.id);
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
          } else if (state is UserListConnectionError) {
            return Center(child: Text(AppStrings.noInternet));
          } else {
            return Center(child: Text(AppStrings.error));
          }
        },
      ),
    );
  }
}

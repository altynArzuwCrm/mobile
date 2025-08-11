import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/contacts_card.dart';
import 'package:crm/features/users/presentation/pages/ui_model/user_ui_model.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

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
      child: BlocProvider.value(
        value: locator<ClientsCubit>(),
        child: BlocBuilder<ClientsCubit, ClientsState>(
          builder: (context, state) {
            if (state is ClientsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ClientsLoaded) {
              final data = state.data;
              return ListView.separated(
                itemCount: data.length,
                padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
                itemBuilder: (context, index) {
                  final item = data[index];
                  final phone = item.contacts?.first.type == 'phone'
                      ? item.contacts?.first.value
                      : '';
                  final email = item.contacts?.first.type == 'email'
                      ? item.contacts?.first.value
                      : '';
                  return ContactsCard(
                    data: UserListUiModel(
                      name: item.name,
                      job: item.companyName,
                      email: email ?? '',
                      companyName: item.companyName,
                      phone: phone ?? '',
                    ),
                    onDelete: () {
                      locator<ClientsCubit>().deleteClient(item.id);
                    },
                    onTap: () {
                      context.push(
                        AppRoutes.clientDetails,
                        extra: {'client': item},
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              );
            } else if (state is ClientsConnectionError) {
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

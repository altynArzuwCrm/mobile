import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart' show MainButton;
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/clients/presentation/cubits/client_details/client_details_cubit.dart';
import 'package:crm/features/clients/presentation/widgets/client_details_page.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/client_entity.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({super.key, required this.client});

  final ClientEntity client;

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final clientDetails = locator<ClientDetailsCubit>();

  @override
  void initState() {
    super.initState();
    clientDetails.getClientDetails(widget.client.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.contactInfo),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppBarIcon(
              onTap: () {
                context.push(
                  AppRoutes.editContact,
                  extra: {'client': widget.client},
                );
              },
              icon: IconAssets.edit,
            ),
          ),
        ],
      ),

      body: BlocProvider.value(
        value: clientDetails,
        child: BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
          builder: (context, state) {
            if (state is ClientDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ClientDetailsLoaded) {
              final data = state.data;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ClientDetailsWidget(
                        name: data.name,
                        company: data.companyName,
                        contacts: data.contacts ?? [],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: MainButton(
                      buttonTile: AppStrings.back,
                      onPressed: () {
                        context.pop();
                      },
                      isLoading: false,
                    ),
                  ),
                ],
              );
            } else if (state is ClientDetailsConnectionError) {
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


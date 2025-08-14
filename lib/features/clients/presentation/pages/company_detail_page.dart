import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/company_details/company_detail_cubit.dart';
import 'package:crm/features/clients/presentation/widgets/client_details_page.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({super.key, required this.title});

  final String title;

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  final companyDetailsCubit = locator<CompanyDetailCubit>();

  @override
  void initState() {
    super.initState();
    companyDetailsCubit.getCompanyDetails(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),

      body: BlocProvider.value(
        value: companyDetailsCubit,
        child: BlocBuilder<CompanyDetailCubit, CompanyDetailState>(
          builder: (context, state) {
            if (state is CompanyDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CompanyDetailLoaded) {
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
            } else if (state is CompanyDetailConnectionError) {
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

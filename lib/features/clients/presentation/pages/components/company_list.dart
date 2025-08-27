import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/companies/company_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({super.key});

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: locator<CompanyCubit>(),
      child: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CompanyLoaded) {
            return ListView.builder(
              itemCount: state.data.length,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              itemBuilder: (context, index) {
                final item = state.data[index];

                return InkWell(
                  onTap: () {
                    context.push('${AppRoutes.companyDetails}/$item');
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is CompanyConnectionError) {
            return Center(child: Text(AppStrings.noInternet));
          }
          return Center(child: Text(AppStrings.error));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';

class CompanyDetailsWidget extends StatelessWidget {
  final List<ClientEntity> data;

  const CompanyDetailsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, contactIndex) {
        final item = data[contactIndex];
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.customer,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.darkBlue,
                ),
              ),

              SizedBox(height: 15),
              ProfileItemWidget(title: AppStrings.name, name: item.name),
              SizedBox(height: 20),
              ProfileItemWidget(
                title: AppStrings.company,
                name: item.companyName,
              ),
              SizedBox(height: 20),
              if (item.contacts != null)
                ...List.generate(item.contacts!.length, (index) {
                  final contact = item.contacts![index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ProfileItemWidget(
                      title: contact.type,
                      name: contact.value,
                    ),
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/clients/presentation/cubits/client_details/client_details_cubit.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({super.key, required this.client});

  final ClientEntity client;

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final clientDetailsCubit = locator<ClientDetailsCubit>();
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;

  late final TextEditingController _companyNameCtrl;

  late List<ContactField> _contactControllers;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.client.name);
    _companyNameCtrl = TextEditingController(text: widget.client.companyName);

    _contactControllers =
        widget.client.contacts?.map((c) {
          return ContactField(
            type: c.type,
            controller: TextEditingController(text: c.value),
          );
        }).toList() ??
        [];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _companyNameCtrl.dispose();

    for (var contactField in _contactControllers) {
      contactField.controller.dispose();
    }

    super.dispose();
  }

  clear() {
    _nameCtrl.clear();
    _companyNameCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.general,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.darkBlue,
                        ),
                      ),

                      SizedBox(height: 15),
                      CustomTextFieldWithTitle(
                        controller: _nameCtrl,
                        title: AppStrings.name,
                        hintText: widget.client.name,
                      ),

                      SizedBox(height: 20),
                      CustomTextFieldWithTitle(
                        controller: _companyNameCtrl,
                        title: AppStrings.company,
                        hintText: widget.client.companyName,
                      ),
                      SizedBox(height: 20),

                      if (_contactControllers.isNotEmpty)
                        ..._contactControllers.map(
                          (field) => ContactWidget(contactField: field),
                        ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocProvider.value(
            value: clientDetailsCubit,
            child: BlocConsumer<ClientDetailsCubit, ClientDetailsState>(
              listener: (context, state) {
                if (state is ClientDetailsLoaded) {
                  toastification.show(
                    context: context,
                    title: Text('успешно'),
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                  final updatedClient = state.data;
                  locator<ClientsCubit>().updateClientLocally(updatedClient);


                  context.pop();
                  clear();
                } else if (state is ClientDetailsError) {
                  toastification.show(
                    context: context,
                    title: Text(AppStrings.error),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                } else if (state is ClientDetailsConnectionError) {
                  toastification.show(
                    context: context,
                    title: Text(AppStrings.noInternet),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: MainButton(
                    buttonTile: AppStrings.save,
                    onPressed: () {
                      bool isValid = formKey.currentState?.validate() ?? false;

                      if (isValid) {
                        final contactsList = _contactControllers.map((c) {
                          return ContactParam(
                            type: c.type,
                            value: c.controller.text,
                          );
                        }).toList();

                        final param = CreateClientParams(
                          id: widget.client.id,
                          name: _nameCtrl.text,
                          companyName: _companyNameCtrl.text,
                          contacts: contactsList,
                        );


                        clientDetailsCubit.editClient(param);
                      }
                    },
                    isLoading: state is ClientDetailsLoading,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactField {
  final String type;
  final TextEditingController controller;

  ContactField({required this.type, required this.controller});
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.contactField});

  final ContactField contactField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithTitle(
          controller: contactField.controller,
          title: contactField.type,
          hintText: '',
          isPhone: contactField.type == 'phone' || contactField.type == 'whatsapp',
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

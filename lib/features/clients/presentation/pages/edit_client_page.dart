import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/clients/presentation/cubits/client_details/client_details_cubit.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
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

  late final TextEditingController _emailCtrl;

  late final TextEditingController _phoneCtrl;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.client.name);
    _companyNameCtrl = TextEditingController(text: widget.client.companyName);
    _emailCtrl = TextEditingController(text: '');
    _phoneCtrl = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _companyNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();

    super.dispose();
  }

  clear() {
    _nameCtrl.clear();
    _companyNameCtrl.clear();
    _emailCtrl.clear();
    _phoneCtrl.clear();
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
                        title: AppStrings.position,
                        hintText: widget.client.companyName,
                      ),
                      SizedBox(height: 20),
                      CustomTextFieldWithTitle(
                        controller: _emailCtrl,
                        title: AppStrings.email,
                        hintText: 'evanyates@gmail.com',
                      ),
                      SizedBox(height: 20),
                      CustomTextFieldWithTitle(
                        controller: _phoneCtrl,
                        title: AppStrings.number,
                        hintText: '',
                        isPhone: true,
                      ),
                      SizedBox(height: 35),
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

                  locator<ClientsCubit>().getAllClients(UserParams());

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
                        clientDetailsCubit.editClient(
                          CreateClientParams(
                            id: widget.client.id,
                            name: _nameCtrl.text,
                            companyName: _companyNameCtrl.text,
                            email: _emailCtrl.text,
                            phone: _phoneCtrl.text,
                          ),
                        );
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

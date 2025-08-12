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
  late final TextEditingController _surnameCtrl;

  late final TextEditingController _positionCtrl;

  late final TextEditingController _emailCtrl;

  late final TextEditingController _numberCtrl;

  late final TextEditingController _locationCtrl;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.client.name);
    _surnameCtrl = TextEditingController(text: '');
    _positionCtrl = TextEditingController(text: '');
    _emailCtrl = TextEditingController(text: '');
    _numberCtrl = TextEditingController(text: '');
    _locationCtrl = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _positionCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _numberCtrl.dispose();

    super.dispose();
  }

  clear() {
    _nameCtrl.clear();
    _surnameCtrl.clear();
    _positionCtrl.clear();
    _emailCtrl.clear();
    _locationCtrl.clear();
    _numberCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainCardWidget(
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
                    controller: _surnameCtrl,
                    title: AppStrings.surname,
                    hintText: 'Иванов',
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _positionCtrl,
                    title: AppStrings.position,
                    hintText: 'UI/UX Designer',
                  ),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          AppStrings.company,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),

                      CustomDropdownField(
                        value: selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory = val;
                          });
                        },
                        padding: EdgeInsets.zero,
                        hintText: widget.client.companyName,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.gray,
                          size: 30,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'a', child: Text("Moscow")),
                          DropdownMenuItem(value: 'l', child: Text("GB")),
                          DropdownMenuItem(value: 'm', child: Text("USA")),
                          DropdownMenuItem(value: 'b', child: Text("Minsk")),
                          DropdownMenuItem(value: 'd', child: Text("London")),
                          DropdownMenuItem(value: 'ah', child: Text("Paris")),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _surnameCtrl,
                    title: AppStrings.location,
                    hintText: 'NYC, New York, USA',
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.gray,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          AppStrings.birthday,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      SelectDateWidget(
                        includeTime: true,
                        dateFormat: 'dd MMMM yyyy, HH:mm',
                        //  locale: const Locale('ru'),
                        onDateSelected: (date) {
                          debugPrint('Selected: $date');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text(
                    AppStrings.contacts,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomTextFieldWithTitle(
                    controller: _emailCtrl,
                    title: AppStrings.email,
                    hintText: 'evanyates@gmail.com',
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _numberCtrl,
                    title: AppStrings.number,
                    hintText: '+1 675 346 23-10',
                  ),
                  SizedBox(height: 35),
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
                        return MainButton(
                          buttonTile: AppStrings.save,
                          onPressed: () {
                            bool isValid =
                                formKey.currentState?.validate() ?? false;

                            if (isValid) {
                              clientDetailsCubit.editClient(
                                CreateClientParams(
                                  id: widget.client.id,
                                  name: _nameCtrl.text,
                                  companyName: widget.client.companyName,
                                  email: _emailCtrl.text,
                                  phone: _numberCtrl.text,
                                ),
                              );
                            }
                          },
                          isLoading: state is ClientDetailsLoading,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/pages/edit_client_page.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddClientWidget extends StatefulWidget {
  const AddClientWidget({super.key});

  @override
  State<AddClientWidget> createState() => _AddClientWidgetState();
}

class _AddClientWidgetState extends State<AddClientWidget> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _companyNameCtrl = TextEditingController();

  String? selectedCategory;

  late final List<ContactField> _contactControllers = [];

  String? selectedType;
  final List<String> contactTypes = [
    'telegram',
    'whatsapp',
    'other',
    'phone',
    'email',
    'instagram',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _companyNameCtrl.dispose();

    for (var c in _contactControllers) {
      c.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.addClient),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),

                    TextFieldTitle(
                      title: AppStrings.name,
                      child: KTextField(
                        controller: _nameCtrl,
                        isSubmitted: false,
                        hintText: '',
                        hintStyle: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        borderColor: AppColors.timeBorder,
                      ),
                    ),

                    SizedBox(height: 20),
                    TextFieldTitle(
                      title: AppStrings.company,
                      child: KTextField(
                        controller: _companyNameCtrl,
                        isSubmitted: false,
                        hintText: '',
                        hintStyle: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        borderColor: AppColors.timeBorder,
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedType,
                            hint: Text('Добавьте контакт'),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  width: 1,
                                ),
                              ),
                            ),
                            items: contactTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: selectedType == null
                              ? null
                              : () {
                                  setState(() {
                                    _contactControllers.add(
                                      ContactField(
                                        type: selectedType!,
                                        controller: TextEditingController(),
                                      ),
                                    );
                                    selectedType = null;
                                  });
                                },
                          child: Text('Добавить'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    if (_contactControllers.isNotEmpty)
                      ..._contactControllers.map(
                        (field) => ContactWidget(contactField: field),
                      ),

                    SizedBox(height: 10),
                    Divider(color: AppColors.divider, thickness: 1),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: () {
                final contactsList = _contactControllers.map((c) {
                  return ContactParam(type: c.type, value: c.controller.text);
                }).toList();

                final newClient = CreateClientParams(
                  name: _nameCtrl.text,
                  companyName: _companyNameCtrl.text,
                  contacts: contactsList,
                  id: null,
                );

                 locator<ClientsCubit>().createClient(newClient);

                context.pop();
              },
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

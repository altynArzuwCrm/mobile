import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProjectWidget extends StatefulWidget {
  const AddProjectWidget({super.key});

  @override
  State<AddProjectWidget> createState() => _AddProjectWidgetState();
}

class _AddProjectWidgetState extends State<AddProjectWidget> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _paymentCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? deadline;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _paymentCtrl.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameCtrl.clear();
    _priceCtrl.clear();
    _paymentCtrl.clear();
    deadline = null;
  }

  void _onSubmit() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите дедлайн')),
      );
      return;
    }

    final price = double.tryParse(_priceCtrl.text.trim()) ?? 0;
    final payment = double.tryParse(_paymentCtrl.text.trim()) ?? 0;

    if (payment > price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Оплата не может превышать сумму')),
      );
      return;
    }

    final newProject = CreateProjectParams(
      title: _nameCtrl.text.trim(),
      deadline: deadline,
      price: price.toString(),
      payment: payment.toString(),
    );

    locator<ProjectsBloc>().add(CreateProject(newProject));

    _resetForm();
    context.pop();
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
            child: BottomSheetTitle(title: AppStrings.addProject),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      TextFieldTitle(
                        title: AppStrings.projectTitle,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите название проекта';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.dedline,
                        child: SelectDateWidget(
                          includeTime: true,
                          dateFormat: 'dd MMMM yyyy, HH:mm',
                          //  locale: const Locale('ru'),
                          onDateSelected: (v) {
                            deadline = v;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Финансовая информация',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: 'Сумма к оплате',
                        child: KTextField(
                          controller: _priceCtrl,
                          isSubmitted: false,
                          hintText: '',
                          keyboardType: TextInputType.number,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите сумму';
                            }
                            final number = double.tryParse(value);
                            if (number == null || number <= 0) {
                              return 'Введите корректное число';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: "Оплачено",
                        child: KTextField(
                          controller: _paymentCtrl,
                          keyboardType: TextInputType.number,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите оплачено';
                            }
                            final number = double.tryParse(value);
                            if (number == null || number < 0) {
                              return 'Введите корректное число';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      Divider(color: AppColors.divider, thickness: 1),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: _onSubmit,
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

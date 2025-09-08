import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/utils/time_format.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditProjectPage extends StatefulWidget {
  const EditProjectPage({super.key, required this.project});

  final ProjectEntity project;

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _priceCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _paymentCtrl;
  DateTime? deadline;

  @override
  void initState() {
    super.initState();
    _priceCtrl = TextEditingController(text: widget.project.totalPrice);
    _nameCtrl = TextEditingController(text: widget.project.title);
    _paymentCtrl = TextEditingController(text: widget.project.paymentAmount);
    deadline = widget.project.deadline;
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _nameCtrl.dispose();
    _paymentCtrl.dispose();

    super.dispose();
  }

  void _resetForm() {
    _nameCtrl.clear();
    _paymentCtrl.clear();
    _priceCtrl.clear();
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
      id: widget.project.id,
      title: _nameCtrl.text.trim(),
      deadline: deadline,
      price: price.toString(),
      payment: payment.toString(),
    );

    locator<ProjectDetailsBloc>().add(EditProject(newProject));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.editProject),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldTitle(
                          title: AppStrings.projectTitle,
                          child: KTextField(
                            controller: _nameCtrl,
                            isSubmitted: false,
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
                            hint: formatDate(deadline),
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

                        // SizedBox(height: 35),
                        //
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(
                        //       IconAssets.calendar,
                        //       width: 22,
                        //       height: 20,
                        //       fit: BoxFit.contain,
                        //     ),
                        //     SizedBox(width: 24),
                        //     Text(
                        //       'Created May 28, 2020',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 14,
                        //         color: AppColors.gray,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            BlocProvider.value(
              value: locator<ProjectDetailsBloc>(),
              child: BlocConsumer<ProjectDetailsBloc, ProjectDetailsState>(
                listener: (context, state) {
                  if (state is ProjectDetailLoaded) {
                    toastification.show(
                      context: context,
                      title: Text(AppStrings.success),
                      autoCloseDuration: const Duration(seconds: 3),
                    );

                    final updatedUser = state.data;
                    locator<ProjectsBloc>().add(
                      UpdateProjectLocally(updatedUser),
                    );

                    _resetForm();
                    context.pop();
                  } else if (state is ProjectDetailError) {
                    toastification.show(
                      context: context,
                      title: Text(AppStrings.error),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  } else if (state is ProjectDetailConnectionError) {
                    toastification.show(
                      context: context,
                      title: Text(AppStrings.noInternet),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: MainButton(
                      buttonTile: AppStrings.save,
                      onPressed: _onSubmit,
                      isLoading: state is ProjectDetailLoading,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

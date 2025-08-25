import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditProjectPage extends StatefulWidget {
  const EditProjectPage({
    super.key,
    required this.project,
    required this.clientId,
    required this.stageId,
  });

  final ProjectEntity project;
  final String clientId;
  final String stageId;

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final formKey = GlobalKey<FormState>();
  String? selectedStageId;
  String? selectedClientId;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;

  final stagesCubit = locator<StageCubit>();
  final clientsCubit = locator<ClientsCubit>();

  @override
  void initState() {
    super.initState();
    clientsCubit.getAllClients(UserParams());
    stagesCubit.getAllStages();
    _priceCtrl = TextEditingController(text: widget.project.totalPrice);
    _nameCtrl = TextEditingController(text: widget.project.title);
    _descriptionCtrl = TextEditingController();

    if(selectedStageId != null)    selectedStageId = widget.stageId;

    if(selectedClientId != null)    selectedClientId = widget.clientId;
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();

    super.dispose();
  }

  void _resetForm() {
    _nameCtrl.clear();
    _descriptionCtrl.clear();
    _priceCtrl.clear();
    selectedClientId = null;
    selectedStageId = null;
    // clientsCubit.selectClient(null);
  }

  void _onSubmit() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (selectedStageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Выберите статус'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            left: 16,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!isValid || selectedClientId == null || selectedStageId == null) return;

    final newProject = CreateProjectParams(
      id: widget.project.id,
      status: selectedStageId!,
      title: _nameCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      clientId: int.parse(selectedClientId!),
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
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFieldTitle(
                          title: AppStrings.description,
                          child: KTextField(
                            controller: _descriptionCtrl,
                            isSubmitted: false,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFieldTitle(
                          title: AppStrings.sum,
                          child: KTextField(
                            controller: _priceCtrl,
                            isSubmitted: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Статус',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                        SizedBox(height: 7),

                        BlocBuilder<StageCubit, StageState>(
                          builder: (context, state) {
                            if (state is StageLoaded) {
                              // final stageName = state.data
                              //     .firstWhere(
                              //       (c) => c.id == int.parse(selectedStageId!),
                              // )
                              //     .name;

                              return CustomDropdownField(
                                value: state.selectedCategory,

                                onChanged: (val) {
                                  locator<StageCubit>().selectCategory(val);
                                  selectedStageId = val;
                                },
                                backgroundColor: AppColors.bgColor,
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.gray,
                                  size: 30,
                                ),
                                items: state.data
                                    .map(
                                      (stage) => DropdownMenuItem(
                                        value: stage.name,
                                        child: Text(stage.displayName),
                                      ),
                                    )
                                    .toList(),
                              );
                            } else {
                              return CustomDropdownField(
                                value: null,
                                onChanged: (v) {},
                                backgroundColor: AppColors.bgColor,
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.gray,
                                  size: 30,
                                ),
                                items: const [],
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppStrings.customer,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                        SizedBox(height: 7),

                        BlocProvider.value(
                          value: locator<ClientsCubit>(),
                          child: BlocBuilder<ClientsCubit, ClientsState>(
                            builder: (context, state) {
                              // String? clientName;
                              // if (state is ClientsLoaded) {
                              //   clientName = state.data
                              //       .firstWhere(
                              //           (c) =>
                              //       c.id == int.parse(selectedClientId!))
                              //       .name;
                              // }

                              final inputDecoration = InputDecoration(

                                hintText: state is ClientsLoading
                                    ? "Loading clients..."
                                    : state is ClientsError
                                    ? "Failed to load"
                                    : "Select client",
                                filled: true,
                                fillColor: AppColors.bgColor,
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.gray,
                                  size: 30,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: AppColors.timeBorder,
                                    // highlight color when focused
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: AppColors.timeBorder,
                                    // highlight color when focused
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: AppColors.timeBorder,
                                    width: 1,
                                  ),
                                ),
                              );

                              if (state is ClientsLoaded) {
                                return EasyAutocomplete(
                                  suggestions: state.data
                                      .map((c) => c.name)
                                      .toList(),
                                 // initialValue: selectedClientId,
                                  onChanged: (value) {
                                    final matches = state.data
                                        .where((c) => c.name == value)
                                        .toList();
                                    if (matches.isNotEmpty) {
                                      final client = matches.first;
                                      //  clientsCubit.selectClient(client.id.toString());
                                      selectedClientId = client.id.toString();
                                    } else {
                                      selectedClientId = null;
                                    }
                                  },
                                  validator: (_) {
                                    if (selectedClientId == null) {
                                      return 'Выберите клиента';
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration,
                                );
                              } else {
                                return IgnorePointer(
                                  ignoring: true,
                                  child: EasyAutocomplete(
                                    suggestions: const <String>[],
                                    initialValue: '',
                                    onChanged: (_) {},
                                    decoration: inputDecoration,
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Text(
                                AppStrings.dedline,
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

                        Row(
                          children: [
                            SvgPicture.asset(
                              IconAssets.calendar,
                              width: 22,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 24),
                            Text(
                              'Created May 28, 2020',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
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
                      title: Text('успешно'),
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

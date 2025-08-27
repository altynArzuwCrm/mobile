import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddProjectWidget extends StatefulWidget {
  const AddProjectWidget({super.key});

  @override
  State<AddProjectWidget> createState() => _AddProjectWidgetState();
}

class _AddProjectWidgetState extends State<AddProjectWidget> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? selectedStage;
  String? selectedClientId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameCtrl.clear();
    _descriptionCtrl.clear();
    selectedClientId = null;
    selectedStage = null;
  }

  void _onSubmit() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid || selectedClientId == null || selectedStage == null) return;

    final newProject = CreateProjectParams(
      status: selectedStage!,
      title: _nameCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      clientId: int.parse(selectedClientId!),
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
                            final inputDecoration = InputDecoration(
                              hintText: state is ClientsLoading
                                  ? "Loading clients..."
                                  : state is ClientsError
                                  ? "Failed to load"
                                  : "Select client",
                              filled: true,
                              fillColor: AppColors.white,
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
                                initialValue: '',
                                onChanged: (value) {
                                  final matches = state.data
                                      .where((c) => c.name == value)
                                      .toList();
                                  if (matches.isNotEmpty) {
                                    final client = matches.first;
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
                            return CustomDropdownField(
                              value: state.selectedCategory,
                              onChanged: (val) {
                                locator<StageCubit>().selectCategory(val);
                                selectedStage = val;
                              },
                              backgroundColor: AppColors.white,
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
                              backgroundColor: AppColors.white,
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
                        ),
                      ),

                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.description,
                        child: KTextField(
                          controller: _descriptionCtrl,
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

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
import 'package:crm/features/stages/presentation/cubits/stage_cubit.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
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

  final stagesCubit = locator<StageCubit>();
  final clientsCubit = locator<ClientsCubit>();
  final formKey = GlobalKey<FormState>();

  String? selectedStage;
  String? selectedClient;

  @override
  void initState() {
    super.initState();
    clientsCubit.getAllClients(UserParams());
    stagesCubit.getAllStages();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();

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
                          if (state is StageLoading) {
                            return const SizedBox.shrink();
                          } else if (state is StageError) {
                            return const Text(AppStrings.error);
                          } else if (state is StageLoaded) {
                            return CustomDropdownField(
                              value: state.selectedCategory,
                              onChanged: (val) {
                                stagesCubit.selectCategory(val);
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
                            return const SizedBox.shrink();
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
                        value: clientsCubit,
                        child: BlocBuilder<ClientsCubit, ClientsState>(
                          builder: (context, state) {
                            if (state is ClientsLoading) {
                              return const SizedBox.shrink();
                            } else if (state is ClientsError) {
                              return const Text(AppStrings.error);
                            } else if (state is ClientsLoaded) {
                              return CustomDropdownField(
                                value: state.selectedClient,
                                onChanged: (val) {
                                  clientsCubit.selectClient(val);
                                  selectedClient = val;
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
                                      (client) => DropdownMenuItem(
                                        value: client.id.toString(),
                                        child: Text(client.name),
                                      ),
                                    )
                                    .toList(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 10),
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
              onPressed: () {
                bool isValid = formKey.currentState?.validate() ?? false;
                if (isValid &&
                    selectedClient != null &&
                    selectedStage != null) {
                  final newProject = CreateProjectParams(
                    status: selectedStage,
                    title: _nameCtrl.text.trim(),
                    description: _descriptionCtrl.text.trim(),
                    id: int.parse(selectedClient ?? ''),
                  );

                  locator<ProjectsBloc>().add(CreateProject(newProject));

                  context.pop();
                }
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

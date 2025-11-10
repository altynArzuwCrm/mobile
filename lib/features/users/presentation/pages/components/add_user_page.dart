import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../roles/presentation/cubits/roles/roles_cubit.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final rolesCubit = locator<RolesCubit>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rolesCubit.getAllRoles();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.addUser)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 10),

                    CustomTextFieldWithTitle(
                      controller: _nameCtrl,
                      title: AppStrings.name,
                      hintText: '',
                      validator: (val){
                        if (val == null || val.isEmpty) {
                          return 'Нужно заполнить имя';
                        } else {
                          return null;
                        }
                      },
                    ),
                    //2
                    SizedBox(height: 20),
                    CustomTextFieldWithTitle(
                      controller: _phoneCtrl,
                      title: AppStrings.phone,
                      hintText: '',
                      isPhone: true,
                    ),

                    //4
                    SizedBox(height: 20),
                    CustomTextFieldWithTitle(
                      controller: _passwordCtrl,
                      title: AppStrings.password,
                      hintText: '',
                      validator: (val){
                        if (val == null || val.isEmpty) {
                          return 'Нужно заполнить пароль';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    BlocProvider.value(
                      value: rolesCubit,
                      child: BlocBuilder<RolesCubit, RolesState>(
                        builder: (context, state) {
                          if (state is RolesLoaded) {
                            final data = state.data;
                            return ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final role = data[index];
                                final isSelected = state.selectedRoleIds
                                    .contains(role.id);

                                return ListTile(
                                  title: Text(
                                    role.displayName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                        )
                                      : const Icon(Icons.circle_outlined),
                                  selected: isSelected,
                                  onTap: () {
                                    rolesCubit.toggleRoleSelection(role.id);
                                  },
                                );
                              },
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: () {
                bool isValid = formKey.currentState?.validate() ?? false;

                if (isValid) {
                  final rolesState = rolesCubit.state;
                  Set<int> selectedRoles = {};

                  if (rolesState is RolesLoaded) {
                    selectedRoles = rolesState.selectedRoleIds;
                  }

                  String username = _nameCtrl.text.toLowerCase().replaceAll(
                    " ",
                    "",
                  );

                  final newUser = CreateUserParams(
                    name: _nameCtrl.text.trim(),
                    username: username,
                    password: _passwordCtrl.text.trim(),
                    phone: _phoneCtrl.text.trim(),
                    roles: selectedRoles.toList(),
                  );

                  if (selectedRoles.isNotEmpty) {
                    locator<UserListCubit>().createUser(newUser);

                    context.pop();
                  }
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

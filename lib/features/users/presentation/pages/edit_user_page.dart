import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/roles/presentation/cubits/roles/roles_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/cubits/user_details/user_details_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, required this.user});

  final UserEntity user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final userDetailsCubit = locator<UserDetailsCubit>();
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;

  late final TextEditingController _phoneCtrl;
  final rolesCubit = locator<RolesCubit>();
  List<int> _selectedRoles = [];

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.user.name);

    _phoneCtrl = TextEditingController(text: widget.user.phone);

    final userRoleIds = widget.user.roles?.map((role) => role.id).toSet();

    rolesCubit.getAllRoles(preselectedRoleIds: userRoleIds);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();

    super.dispose();
  }

  clear() {
    _nameCtrl.clear();
    _phoneCtrl.clear();
    _selectedRoles.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                        hintText: widget.user.name,
                      ),

                      SizedBox(height: 20),

                      CustomTextFieldWithTitle(
                        controller: _phoneCtrl,
                        title: AppStrings.number,
                        hintText: '',
                        isPhone: true,
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppStrings.position,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                      SizedBox(height: 7),

                      BlocProvider.value(
                        value: rolesCubit,
                        child: BlocBuilder<RolesCubit, RolesState>(
                          builder: (context, state) {
                            if (state is RolesLoaded) {
                              final data = state.data;
                              _selectedRoles = state.selectedRoleIds.toList();
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

            BlocConsumer<UserDetailsCubit, UserDetailsState>(
              listener: (context, state) {
                if (state is UserDetailsLoaded) {
                  toastification.show(
                    context: context,
                    title: Text('успешно'),
                    autoCloseDuration: const Duration(seconds: 3),
                  );

                  final updatedUser = state.data;
                  locator<UserListCubit>().updateUserLocally(updatedUser);

                  context.pop();
                  clear();
                } else if (state is UserDetailsError) {
                  toastification.show(
                    context: context,
                    title: Text(AppStrings.error),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                } else if (state is UserDetailsConnectionError) {
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
                      if (selectedRoles.isNotEmpty) {
                        userDetailsCubit.editUser(
                          CreateUserParams(
                            id: widget.user.id,
                            name: _nameCtrl.text,
                            username: username,
                            phone: _phoneCtrl.text,
                            roles: selectedRoles.toList(),
                          ),
                        );
                      }
                    }
                  },
                  isLoading: state is UserDetailsLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

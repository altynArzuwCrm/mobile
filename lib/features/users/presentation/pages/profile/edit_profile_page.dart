import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/roles/presentation/cubits/roles/roles_cubit.dart';
import 'package:crm/features/roles/presentation/pages/roles_widget.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final UserEntity user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _numberCtrl;

  final rolesCubit = locator<RolesCubit>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _numberCtrl = TextEditingController(text: widget.user.phone);
    rolesCubit.getAllRoles();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _numberCtrl.dispose();

    super.dispose();
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
                      controller: _numberCtrl,
                      title: AppStrings.number,
                      hintText: widget.user.phone,
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
                                final isSelected = state.selectedRoleIds.contains(role.id);

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
                                      ? Icon(Icons.check_circle, color: AppColors.primary)
                                      : const Icon(Icons.circle_outlined),
                                  selected: isSelected,
                                  onTap: (){
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
            MainButton(
              buttonTile: AppStrings.save,
              onPressed: () {},
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}

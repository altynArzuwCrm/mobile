import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/stages/data/models/stage_model.dart';
import 'package:crm/features/users/data/models/user_model.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

class StageCategoryWidget extends StatefulWidget {
  final StageModel stage;
  final List<UserModel> users;
  final void Function(UserModel?) onSelectUser;

  const StageCategoryWidget({
    super.key,
    required this.stage,
    required this.users,
    required this.onSelectUser,
  });

  @override
  State<StageCategoryWidget> createState() => _StageCategoryWidgetState();
}

class _StageCategoryWidgetState extends State<StageCategoryWidget> {
  String? selectedUserName;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      hintText: AppStrings.selectUser,
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
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.timeBorder,
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

    return TextFieldTitle(
      title: widget.stage.displayName,
      child: EasyAutocomplete(
        suggestions: widget.users.map((u) => u.name).toList(),
        initialValue: selectedUserName ?? '',
        onChanged: (value) {
          final matches =
          widget.users.where((u) => u.name == value).toList();
          if (matches.isNotEmpty) {
            final selectedUser = matches.first;
            selectedUserName = matches.first.name;
            widget.onSelectUser(selectedUser);
          } else {
            selectedUserName = null;
            widget.onSelectUser(null);
          }
          setState(() {});
        },
        validator: (_) {
          if (selectedUserName == null) return  AppStrings.selectUser;
          return null;
        },
        decoration: inputDecoration,
      ),
    );
  }
}


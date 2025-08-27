import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectSelector extends StatelessWidget {
  const ProjectSelector({
    super.key,
    required this.onSelectProject,
    required this.selectedIndex,
  });

  final ValueChanged onSelectProject;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        final inputDecoration = InputDecoration(
          hintText: state is ProjectsLoading
              ? "Loading projects..."
              : state is ClientsError
              ? "Failed to load"
              : "Select project",
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
            borderSide: const BorderSide(color: AppColors.timeBorder, width: 1),
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
            borderSide: const BorderSide(color: AppColors.timeBorder, width: 1),
          ),
        );
        if (state is! ProjectsLoaded) {
          return IgnorePointer(
            ignoring: true,
            child: EasyAutocomplete(
              suggestions: const <String>[],
              initialValue: '',
              onChanged: (_) {},
              decoration: inputDecoration,
            ),
          );
        } else {
          return EasyAutocomplete(
            suggestions: state.data.map((c) => c.title).toList(),
            initialValue: '',
            onChanged: (value) {
              final matches = state.data
                  .where((c) => c.title == value)
                  .toList();
              if (matches.isNotEmpty) {
                final project = matches.first;
                onSelectProject(project.id.toString());
              } else {
                onSelectProject(null);
              }
            },
            validator: (v) {
              if (selectedIndex == 1 && v == null) {
                return 'Выберите проект';
              }
              return null;
            },
            decoration: inputDecoration,
          );
        }
      },
    );
  }
}

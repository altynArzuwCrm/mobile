import 'dart:async';

import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectSelector extends StatefulWidget {
  const ProjectSelector({
    super.key,
    required this.onSelectProject,
    required this.selectedIndex,
  });

  final ValueChanged onSelectProject;
  final int selectedIndex;

  @override
  State<ProjectSelector> createState() => _ProjectSelectorState();
}

class _ProjectSelectorState extends State<ProjectSelector> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  String? _lastQuery; // to avoid firing the same request repeatedly

  @override
  void dispose() {
    _debounce?.cancel();

    // make sure suggestions overlay is closed before disposal
    _focusNode.unfocus();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value, List<ProjectEntity> projects) {
    // Cancel previous timer
    _debounce?.cancel();

    // Start a new timer: backend request only fires after 500ms of inactivity
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = value.trim();
      if (query.isEmpty) {
        widget.onSelectProject(null);
        _lastQuery = null;
        return;
      }

      final lowerQuery = query.toLowerCase();

      // Check exact match
      final matches = projects.where(
        (p) => p.title.toLowerCase() == lowerQuery,
      );
      final exactMatch = matches.isNotEmpty ? matches.first : null;
      if (exactMatch != null) {
        widget.onSelectProject(exactMatch.id.toString());
        _lastQuery = null;
        return;
      }

      // Check partial match (suggestions only)
      final partialMatch = projects.any(
        (p) => p.title.toLowerCase().startsWith(lowerQuery),
      );
      if (partialMatch) {
        _lastQuery = null;
        return; // show suggestions, no backend request
      }

      // No local match → call backend if query changed
      if (_lastQuery == query) return;
      _lastQuery = query;

      locator<ProjectsBloc>().add(GetAllProjects(ProjectParams(search: query)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        final names = state is ProjectsLoaded
            ? state.data.map((c) => c.title).toList()
            : <String>[];

        final inputDecoration = InputDecoration(
          hintText: state is ProjectsLoading
              ? AppStrings.loadingProjects
              : state is ClientsError
              ? AppStrings.notLoaded
              : AppStrings.selectProject,
          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),

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

        return EasyAutocomplete(
          controller: _controller,
          focusNode: _focusNode,
          suggestions: names,
          debounceDuration: Duration.zero,
          inputTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),

          // we handle debounce manually
          onChanged: (value) => _onSearchChanged(
            value,
            state is ProjectsLoaded ? state.data : [],
          ),
          validator: (v) {
            if (v == null ||
                !names.map((n) => n.toLowerCase()).contains(v.toLowerCase())) {
              return AppStrings.selectProject;
            }
            return null;
          },

          decoration: inputDecoration,
        );
      },
    );
  }
}

import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/sort_order_button.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterProjectsWidget extends StatefulWidget {
  const FilterProjectsWidget({
    super.key,
    required this.initialSortOrder,
    required this.sortBy,
  });

  final String? sortBy;
  final String initialSortOrder;

  @override
  State<FilterProjectsWidget> createState() => _FilterProjectsWidgetState();
}

class _FilterProjectsWidgetState extends State<FilterProjectsWidget> {
  late String sortOrder;
  late String? selectedSortBy;

  @override
  void initState() {
    super.initState();
    sortOrder = widget.initialSortOrder;
    selectedSortBy = widget.sortBy;
  }

  @override
  void dispose() {
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
            child: BottomSheetTitle(title: AppStrings.filter),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: [
                CategoryBtn(
                  title: "По название",
                  isSelected: selectedSortBy == 'name',
                  onTap: () {
                    setState(() {
                      selectedSortBy = 'name';
                    });
                  },
                ),
                CategoryBtn(
                  title: "По времени",
                  isSelected: selectedSortBy == 'created_at',
                  onTap: () {
                    setState(() {
                      selectedSortBy = 'created_at';
                    });
                  },
                ),
                CategoryBtn(
                  title: "По дедлайну",
                  isSelected: selectedSortBy == 'deadline',
                  onTap: () {
                    setState(() {
                      selectedSortBy = 'deadline';
                    });
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SortOrderSelector(
              sortOrder: sortOrder,
              isIconOnly: false,
              onChanged: (val) {
                setState(() => sortOrder = val);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MainButton(
              buttonTile: AppStrings.filter,
              onPressed: () {
                final params = ProjectParams(
                  sortOrder: sortOrder,
                  sortBy: selectedSortBy,
                  page: 1,
                );
                locator<ProjectsBloc>().add(
                  GetAllProjects(params),
                );
                context.pop(sortOrder);
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

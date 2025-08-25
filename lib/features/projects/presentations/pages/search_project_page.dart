import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/search_project/search_project_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/project_card.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsSearchPage extends StatefulWidget {
  const ProjectsSearchPage({super.key});

  @override
  State<ProjectsSearchPage> createState() => _ProjectsSearchPageState();
}

class _ProjectsSearchPageState extends State<ProjectsSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final searchCubit = locator<SearchProjectCubit>();

  @override
  void dispose() {
    _searchCtrl.dispose();
    searchCubit.initializeSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.search),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 58), //56
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: HomePageSearchWidget(
              searchCtrl: _searchCtrl,
              onSearch: () {
                setState(() {});
                searchCubit.searchProjects(
                  ProjectParams(search: _searchCtrl.text.trim()),
                );
              },
              onClear: () {
                setState(() {});
                _searchCtrl.clear();
                searchCubit.initializeSearch();
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ),
      ),
      body: BlocProvider.value(
        value: searchCubit,
        child: BlocBuilder<SearchProjectCubit, SearchProjectState>(
          builder: (context, state) {
            if (state is SearchProjectInitial) {
              return const Center(child: Text('Search Projects'));
            } else if (state is SearchProjectLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchFoundedProjects) {
              final data = state.data;
              return ListView.separated(
                // controller: _scrollController,
                itemCount: data.length,
                padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ProjectCard(
                    id: item.id,
                    title: item.title,
                    deadline: item.deadline,
                    ordersCount: item.orders?.length ?? 0,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              );
            } else if (state is SearchNotFoundedProjects) {
              return Center(child: Text('Not founded'));
            } else if (state is SearchProjectsConnectionError) {
              return Center(child: Text(AppStrings.noInternet));
            } else {
              return Center(child: Text(AppStrings.error));
            }
          },
        ),
      ),
    );
  }
}

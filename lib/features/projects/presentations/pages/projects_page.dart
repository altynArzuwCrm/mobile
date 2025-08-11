import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_footer.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/core/network/internet_bloc/internet_bloc.dart';
import 'package:crm/features/orders/presentation/components/add_order_widget.dart';
import 'package:crm/features/orders/presentation/components/filter_widget.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/settings/presentation/widgets/project_card.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final projectBloc = locator<ProjectsBloc>();
  int _currentPage = 1;
  int isSelected = 0;
  int isSelected2 = 1;
  final Set<int> selectedIndices = {};
  @override
  void initState() {
    super.initState();

    projectBloc.add(GetAllProjects(ProjectParams(page: _currentPage)));
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;
    projectBloc.add(GetAllProjects(ProjectParams(page: _currentPage)));
    _refreshController.refreshCompleted();
  }

  void _onLoad() async {
    if (projectBloc.canLoad) {
      _currentPage++;
      projectBloc.add(GetAllProjects(ProjectParams(page: _currentPage)));
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.projects),
        actions: [
          selectedIndices.isNotEmpty ?
          AppBarIcon(onTap: () {}, icon: IconAssets.delete)

              : SizedBox.shrink()
          ,
          SizedBox(width: 7),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppBarIcon(onTap: _openSort, icon: IconAssets.filter),
          ),
        ],
      ),
      body: Stack(
        children: [
          SmartRefresher(
            controller: _refreshController,
            scrollController: _scrollController,
            enablePullUp: projectBloc.canLoad,
            onLoading: _onLoad,
            onRefresh: _onRefresh,
            footer: KFooter(),
            child: BlocListener<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state is InternetDisConnected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppStrings.noInternet),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16,
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(minutes: 5),
                    ),
                  );
                } else if (state is InternetConnected) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
              child: BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  switch (state) {
                    case ProjectsLoading():
                      return Center(child: CircularProgressIndicator());
                    case ProjectsLoaded():
                      final data = state.data;
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: data.length,
                        padding: EdgeInsets.fromLTRB(25, 15, 25, 85),
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return ProjectCard(
                            id: item.id,
                            title: item.title,
                            deadline: item.deadline,
                            ordersCount: item.orders?.length ?? 0,

                            isSelected: index == isSelected,
                            onTap: () {
                              setState(() {
                                isSelected = index;
                              });
                            },


                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                      );
                    case ProjectsError():
                      return Center(child: Text(AppStrings.error));
                    case ProjectsConnectionError():
                      return Center(child: Text(AppStrings.noInternet));
                  }
                },
              ),
            ),
          ),

          BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoaded) {
                return Positioned(
                  right: 15,
                  bottom: 100,
                  child: FloatingActionButton(
                    onPressed: _openAddOrder,
                    child: Icon(Icons.add),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),

          BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoaded) {
                return Positioned(
                  right: 25,
                  bottom: 15,
                  left: 15,
                  child: MainButton(
                    buttonTile: AppStrings.back,
                    onPressed: () {},
                    isLoading: false,
                  ),
                );
              }
              return SizedBox.shrink();
              },
          ),
        ],
      ),
    );
  }

  void _openSort() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return FilterWidget();
      },
    );
  }

  void _openAddOrder() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddOrderWidget();
      },
    );
  }
}

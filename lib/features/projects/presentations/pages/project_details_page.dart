import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/general_info.dart';
import 'package:crm/features/projects/presentations/blocs/project_details/project_details_bloc.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/projects/presentations/blocs/search_project/search_project_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/project_detail_order_widget.dart';
import 'package:crm/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final detailBloc = locator<ProjectDetailsBloc>();
  final searchCubit = locator<SearchProjectCubit>();

  @override
  void initState() {
    super.initState();

    detailBloc.add(GetProjectById(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.projectDetail),
          actions: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                if (userState is! UserLoaded) {
                  return SizedBox.shrink();
                }

                // Extract role IDs
                final roles = userState.data.roles?.map((e) => e.id) ?? [];
                final canDelete = roles.any((id) => id == 1 || id == 2);

                return canDelete
                    ? Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: AppBarIcon(
                          onTap: () {
                            _delete(context);
                          },
                          icon: IconAssets.delete,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 20),
              child: AppBarIcon(
                onTap: () {
                  final state = detailBloc.state;
                  if (state is ProjectDetailLoaded) {
                    context.push(
                      AppRoutes.editProject,
                      extra: {"project": state.data},
                    );
                  }
                },
                icon: IconAssets.edit,
              ),
            ),
          ],
        ),
        body: BlocProvider.value(
          value: detailBloc,

          child: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
            builder: (context, state) {
              if (state is ProjectDetailLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProjectDetailLoaded) {
                final data = state.data;

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralInfo(
                              name: data.title,
                              deadline: data.deadline,
                              price: data.paymentAmount,
                              createdTime: data.createdAt,
                            ),
                            SizedBox(height: 20),

                            Text(
                              AppStrings.orders,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 85),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: data.orders?.length,
                          (BuildContext context, int index) {
                            final item = data.orders?[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                25,
                                20,
                                25,
                                0,
                              ),
                              child: ProjectDetailOrderWidget(
                                title: item?.product.name ?? '',
                                client: item?.client.name ?? '',
                                deadline: item?.deadline ?? '',
                                id: item?.id,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ProjectDetailConnectionError) {
                return Center(child: Text(AppStrings.noInternet));
              } else {
                return Center(child: Text(AppStrings.error));
              }
            },
          ),
        ),
      ),
    );
  }

  _delete(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 24,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, // or AppColors.background
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppStrings.confirmDelete,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.confirmedDelete,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 24),

                // Cancel + Logout buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: MainButton(
                        buttonTile: AppStrings.cancel,
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        isLoading: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MainButton(
                        buttonTile: AppStrings.delete,
                        onPressed: () {
                          final state = detailBloc.state;
                          if (state is ProjectDetailLoaded) {
                            locator<ProjectsBloc>().add(
                              DeleteProject(widget.id),
                            );

                            if (searchCubit.projects.isNotEmpty) {
                              searchCubit.deleteProject(widget.id);
                            }

                            context.pop();
                          }
                        },
                        isLoading: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

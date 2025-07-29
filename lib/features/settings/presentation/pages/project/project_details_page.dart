import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/components/project.dart';
import 'package:crm/features/settings/presentation/widgets/project_detail_order_widget.dart';
import 'package:crm/features/settings/presentation/widgets/project_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.projectDetail),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: AppBarIcon(
                onTap: () {
                  context.push(AppRoutes.editProject);
                },
                icon: IconAssets.edit,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectInfoWidget(),

                        SizedBox(height: 20),
                        Project(title: AppStrings.project),
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
                    delegate: SliverChildBuilderDelegate(childCount: 5, (
                      BuildContext context,
                      int index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                        child: ProjectDetailOrderWidget(),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 25,
              left: 25,
              child: MainButton(
                buttonTile: AppStrings.back,
                onPressed: () {},
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

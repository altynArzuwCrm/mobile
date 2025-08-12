import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/settings/presentation/widgets/edit_project_info_widget.dart';
import 'package:flutter/material.dart';

import '../../../orders/presentation/pages/components/detail_components/project.dart' show Project;

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.editProject),
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
                        EditProjectInfoWidget(),

                        SizedBox(height: 20),
                        Project(title: AppStrings.project),
                        SizedBox(height: 20),
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
                        child: SizedBox()//ProjectDetailOrderWidget(),
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
                buttonTile: AppStrings.save,
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

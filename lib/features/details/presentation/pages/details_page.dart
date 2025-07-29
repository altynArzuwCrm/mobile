import 'package:crm/common/widgets/tabbar_child_widget.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/details/presentation/components/comments_list.dart';
import 'package:crm/features/details/presentation/components/general_info.dart';
import 'package:crm/features/details/presentation/components/history_list.dart';
import 'package:crm/features/details/presentation/components/product.dart';
import 'package:crm/features/details/presentation/components/project.dart';
import 'package:crm/features/details/presentation/components/comments_and_history.dart';
import 'package:crm/features/details/presentation/widgets/details_appbar.dart';
import 'package:crm/features/details/presentation/widgets/tabbar_delegate.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: false,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              DetailsAppbar(),
                              SizedBox(height: 15),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GeneralInfo(),
                                    SizedBox(height: 20),
                                    Product(),
                                    SizedBox(height: 20),
                                    Project(title: AppStrings.client),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),

                    ///  Pinned TabBar
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TabBarDelegate(
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CommentsAndHistory(),
                        ),
                      ),
                    ),
                  ];
                },
            body: TabBarView(
              children: [
                TabChildWidget(
                  childKey: AppStrings.comments,
                  delegate: SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 20,
                    ),
                    sliver: const CommentsList(),
                  ),
                  isComment: true,
                ),
                TabChildWidget(
                  childKey: AppStrings.history,
                  delegate: HistoryList(),
                  isComment: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/tabbar_child_widget.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/components/comments_list.dart';
import 'package:crm/features/details/presentation/components/general_info.dart';
import 'package:crm/features/details/presentation/components/history_list.dart';
import 'package:crm/features/details/presentation/components/product.dart';
import 'package:crm/features/details/presentation/components/project.dart';
import 'package:crm/features/details/presentation/components/comments_and_history.dart';
import 'package:crm/features/details/presentation/widgets/tabbar_delegate.dart';
import 'package:flutter/cupertino.dart';
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Platform.isIOS
                                          ? CupertinoIcons.back
                                          : Icons.arrow_back,
                                    ),
                                  ),
                                  Text(
                                    'Наименование заказа',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                  AppBarIcon(
                                    icon: IconAssets.edit,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: GeneralInfo(),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Product(),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Project(title: 'Заказчик',),
                              ),
                              SizedBox(height: 20),
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
                  childKey: 'Комментарии',
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
                  childKey: 'История',
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

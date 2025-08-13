import 'package:crm/common/widgets/tabbar_child_widget.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/cubits/comment/comment_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/order_details/order_detail_cubit.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/comments_list.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/general_info.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/history_list.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/product.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/comments_and_history.dart';
import 'package:crm/features/orders/presentation/widgets/details_appbar.dart';
import 'package:crm/features/orders/presentation/widgets/tabbar_delegate.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/detail_components/project.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final orderDetailsCubit = locator<OrderDetailCubit>();

  @override
  void initState() {
    super.initState();

    orderDetailsCubit.getOrderDetail(widget.id);
    locator<CommentCubit>().getOrderComments(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: BlocProvider.value(
            value: orderDetailsCubit,
            child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
              builder: (context, state) {
                if (state is OrderDetailLoading) {
                  return Scaffold(appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()),);
                } else if (state is OrderDetailLoaded) {
                  final data = state.data;

                  return NestedScrollView(
                    floatHeaderSlivers: false,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                          return [
                            SliverOverlapAbsorber(
                              handle:
                                  NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context,
                                  ),
                              sliver: SliverList(
                                delegate: SliverChildListDelegate([
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      DetailsAppbar(order: data),
                                      SizedBox(height: 15),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GeneralInfo(
                                              name: data.client?.name,
                                              deadline: data.deadline,
                                              price: data.project?.totalPrice,
                                              createdTime: data.createdAt,
                                            ),
                                            SizedBox(height: 20),
                                            Product(title: data.product?.name),
                                            SizedBox(height: 20),
                                            ProjectWidget(title: data.project?.title),
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
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  padding: EdgeInsets.zero,
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
                          orderId: data.id,
                        ),
                        TabChildWidget(
                          childKey: AppStrings.history,
                          delegate: HistoryList(),
                          isComment: false,
                        ),
                      ],
                    ),
                  );
                } else if (state is OrderDetailConnectionError) {
                  return Center(child: Text(AppStrings.noInternet));
                } else {
                  return Center(child: Text(AppStrings.error));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

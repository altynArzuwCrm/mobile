import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/comment/comment_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/order_details/order_detail_cubit.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/comments_list.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/product.dart';
import 'package:crm/features/orders/presentation/widgets/details_appbar.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'components/detail_components/order_info.dart';
import 'components/detail_components/project.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final orderDetailsCubit = locator<OrderDetailCubit>();
  final _commentCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    orderDetailsCubit.getOrderDetail(widget.id);
    locator<CommentCubit>().getOrderComments(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    _commentCtrl.clear();
    _commentCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider.value(
          value: orderDetailsCubit,
          child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
            builder: (context, state) {
              if (state is OrderDetailLoading) {
                return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is OrderDetailLoaded) {
                final data = state.data;

                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      OrderInfo(model: data),
                                      SizedBox(height: 20),
                                      ProductCard(title: data.product?.name),
                                      SizedBox(height: 20),
                                      ProjectWidget(
                                        title: data.client?.name,
                                        contacts: data.client?.contacts ?? [],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 20,
                          ),
                          sliver: const CommentsList(),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 150)),
                      ],
                    ),
                    Positioned(
                      left: 25,
                      right: 25,
                      bottom: 0,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(bottom: 15),
                        child: SafeArea(
                          top: false,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Form(
                                    key: formKey,
                                    child: TextField(
                                      controller: _commentCtrl,
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterText,
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                          16,
                                          16,
                                          6,
                                          16,
                                        ),
                                        fillColor: AppColors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        focusColor: AppColors.primary,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.primary,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.timeBorder,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),

                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();

                                            final isValid =
                                                formKey.currentState
                                                    ?.validate() ??
                                                false;

                                            if (isValid) {
                                              locator<CommentCubit>()
                                                  .createOrderComments(
                                                    CommentParams(
                                                      orderId: data.id,
                                                      text: _commentCtrl.text
                                                          .trim(),
                                                    ),
                                                  );
                                              _commentCtrl.clear();
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: 6,
                                              top: 2,
                                              bottom: 2,
                                            ),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: AppColors.sendBtn,
                                            ),
                                            child: SvgPicture.asset(
                                              IconAssets.send,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),
                              MainButton(
                                buttonTile: AppStrings.back,
                                onPressed: () {
                                  context.pop();
                                },
                                isLoading: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is OrderDetailConnectionError) {
                return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: Text(AppStrings.noInternet)),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: Text(AppStrings.error)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/comment/comment_cubit.dart';
import 'package:crm/features/orders/presentation/pages/components/detail_components/comments_list.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TabChildWidget extends StatefulWidget {
  const TabChildWidget({
    super.key,
    required this.childKey,
    required this.delegate,
    required this.isComment,
    this.orderId,
  });

  final String childKey;
  final Widget delegate;
  final bool isComment;
  final int? orderId;

  @override
  State<TabChildWidget> createState() => _TabChildWidgetState();
}

class _TabChildWidgetState extends State<TabChildWidget> {
  final _commentCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _commentCtrl.clear();
    _commentCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            CustomScrollView(
              key: PageStorageKey<String>(widget.childKey),
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 20,
                  ),
                  sliver: const CommentsList(),
                ),
                if (widget.isComment)
                  SliverToBoxAdapter(child: SizedBox(height: 150)),
              ],
            ),
            if (widget.isComment)
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
                                  hintText: "Введите текст",
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
                                    borderRadius: BorderRadius.circular(10),
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      final isValid =
                                          formKey.currentState?.validate() ??
                                          false;

                                      if (isValid) {
                                        locator<CommentCubit>()
                                            .createOrderComments(
                                              CommentParams(
                                                orderId: widget.orderId ?? 0,
                                                text: _commentCtrl.text.trim(),
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
                                        borderRadius: BorderRadius.circular(14),
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

                        const SizedBox(height: 35),
                        MainButton(
                          buttonTile: 'Вернуться',
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
      },
    );
  }
}

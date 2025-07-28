import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabChildWidget extends StatelessWidget {
  const TabChildWidget({
    super.key,
    required this.childKey,
    required this.delegate,
    required this.isComment,
  });

  final String childKey;
  final Widget delegate;
  final bool isComment;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            CustomScrollView(
              key: PageStorageKey<String>(childKey),
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                delegate,
                if (isComment) SliverToBoxAdapter(child: SizedBox(height: 150)),
                // SliverToBoxAdapter(
                //   child: Positioned(
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         children: [
                //           TextField(
                //             decoration: InputDecoration(
                //               hintText: "Write a comment...",
                //               border: OutlineInputBorder(),
                //             ),
                //             maxLines: 3,
                //           ),
                //           const SizedBox(height: 10),
                //           SizedBox(
                //             width: double.infinity,
                //             child: ElevatedButton(
                //               onPressed: () {
                //                 // Handle comment submit
                //               },
                //               child: const Text("Submit"),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            if (isComment)
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
                        Container(
                          child: Stack(
                            children: [
                              TextField(
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
                            ],
                          ),
                        ),

                        const SizedBox(height: 35),
                        MainButton(
                          buttonTile: 'Вернуться',
                          onPressed: () {},
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

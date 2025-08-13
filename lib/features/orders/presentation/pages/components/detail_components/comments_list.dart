import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/cubits/comment/comment_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/comment_card.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<CommentCubit>(),
      child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          if (state is CommentLoading) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state is CommentLoaded) {
            final data = state.data;

            if (data.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text('Нет комментариев')),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: data.length,
                    (BuildContext context, int index) {
                  final item = data[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 8, 0),
                    child: CommentCard(
                      showTime: index == 0,
                      model: item,
                      onDelete: () {
                        locator<CommentCubit>().deleteOrderComment(
                          item.id,
                          item.orderId,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is CommentConnectionError) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text(AppStrings.noInternet)),
              ),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text(AppStrings.error)),
              ),
            );
          }
        },
      ),
    );
  }
}

// class CommentsList extends StatelessWidget {
//   const CommentsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: locator<CommentCubit>(),
//       child: BlocBuilder<CommentCubit, CommentState>(
//         builder: (context, state) {
//           if (state is CommentLoading) {
//             return SliverToBoxAdapter(
//               child: Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is CommentLoaded) {
//             final data = state.data;
//             return SliverList(
//               delegate: SliverChildBuilderDelegate(childCount: data.length, (
//                 BuildContext context,
//                 int index,
//               ) {
//                 final item = data[index];
//                 return Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 15, 8, 0),
//                   child: CommentCard(
//                     showTime: index == 0,
//                     model: item,
//                     onDelete: () {
//                       locator<CommentCubit>().deleteOrderComment(
//                         item.id,
//                         item.orderId,
//                       );
//                     },
//                   ),
//                 );
//               }),
//             );
//           } else if (state is CommentConnectionError) {
//             return SliverToBoxAdapter(
//               child: Center(child: Text(AppStrings.noInternet)),
//             );
//           } else {
//             return SliverToBoxAdapter(
//               child: Center(child: Text(AppStrings.error)),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/tabbar_child_widget.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/components/general_info.dart';
import 'package:crm/features/details/presentation/components/product.dart';
import 'package:crm/features/details/presentation/components/project.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/details/presentation/components/comments_and_history.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: DetailsBody(),
              ),
            ];
          },

          body: TabBarView(
            children: [
              TabChildWidget(
                childKey:
               'annotation',
                delegate: SliverList(
                  delegate: SliverChildListDelegate([
                    Container(height: 50,
                    color: Colors.yellow,)
                  ]),
                ),
              ),
              TabChildWidget(
                childKey: 'content',
                delegate: Lw(),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class Lw extends StatelessWidget {
  const Lw({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
            (BuildContext context, int index) {

          return Container(
            height: 40,
            margin: EdgeInsets.all(10),
            color: Colors.red,
          );
        },
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralInfo(),
             SizedBox(height: 20),
             Product(),
             SizedBox(height: 20),
             Project(),
             SizedBox(height: 20),
             CommentsAndHistory(),


            /// tabbar widget add




          ],
        ),
      ),
    );
  }
}




// class DetailsPage extends StatelessWidget {
//   const DetailsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Наименование заказа'),
//
//         actions: [AppBarIcon(icon: IconAssets.edit, onTap: () {})],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
//         child: CustomScrollView(
//           slivers: [
//              GeneralInfo()),
//              SizedBox(height: 20)),
//              Product()),
//              SizedBox(height: 20)),
//              Project()),
//              SizedBox(height: 20)),
//              CommentsAndHistory()),
//
//
//  /// tabbar widget add
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }

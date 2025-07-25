import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Наименование заказа'),

        actions: [AppBarIcon(icon: IconAssets.edit, onTap: () {})],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: OrderCard(

            ),
          )
        ],
      ),
    );
  }
}

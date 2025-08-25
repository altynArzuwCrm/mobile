// import 'package:crm/core/constants/strings/app_strings.dart';
// import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
// import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
// import 'package:flutter/material.dart';
//
// class UserOrderPage extends StatelessWidget {
//   const UserOrderPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppStrings.orders),
//         centerTitle: true,
//       ),
//
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(child: SizedBox(height: 15)),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 50,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 itemCount: 20,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: CategoryBtn(
//                       title: 'Vse $index',
//                       isSelected: index == 0,
//                       onTap: () {},
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(child: SizedBox(height: 20)),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                 return UserOrderCard();
//               },
//               childCount: 10, // Set the number of children here
//             ),
//           ),
//           SliverToBoxAdapter(child: SizedBox(height: 70)),
//
//         ],
//       ),
//     );
//   }
// }

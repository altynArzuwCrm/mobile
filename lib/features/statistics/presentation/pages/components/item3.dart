import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:crm/features/statistics/presentation/cubits/user_stat/user_stat_cubit.dart';
import 'package:crm/features/statistics/presentation/widgets/card_widget.dart';
import 'package:crm/features/statistics/presentation/widgets/chart3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item3 extends StatelessWidget {
  const Item3({super.key});
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: BlocBuilder<UserStatCubit, UserStatState>(
        builder: (context, state) {
          List<OrdersByUser> usersData = [];

          if (state is UserStatLoaded) {
            usersData = state.data.ordersByUser;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Эффективность сотрудников',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(height: 10),

              Divider(color: AppColors.divider, thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  child: StatsBarChart(users: usersData),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

//
//
// class Item3 extends StatefulWidget {
//   final List<OrdersByUser> users;
//
//   const Item3({super.key, required this.users});
//
//   @override
//   State<Item3> createState() => _Item3State();
// }
//
// class _Item3State extends State<Item3> {
//   String? selectedCategory;
//
//   @override
//   Widget build(BuildContext context) {
//     final maxTotal = widget.users
//         .map((u) => u.total)
//         .fold<int>(0, (prev, e) => e > prev ? e : prev);
//
//     final maxOrders = widget.users
//         .map((u) => u.orders.length)
//         .fold<int>(0, (prev, e) => e > prev ? e : prev);
//
//     return CardWidget(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Эффективность сотрудников',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     color: AppColors.gray,
//                   ),
//                 ),
//                 CustomDropdown(
//                   value: selectedCategory,
//                   padding: EdgeInsets.zero,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     color: AppColors.gray,
//                   ),
//                   hintText: 'Месяц',
//                   onChanged: (val) {
//                     setState(() {
//                       selectedCategory = val;
//                     });
//                   },
//                   color: Colors.transparent,
//                   iconColor: AppColors.gray,
//                   bgColor: AppColors.bgColor,
//                   items: const [
//                     DropdownMenuItem(value: 'a', child: Text("Week")),
//                     DropdownMenuItem(value: 'l', child: Text("Month")),
//                     DropdownMenuItem(value: 'm', child: Text("Year")),
//                   ],
//                 ),
//               ],
//             ),
//             Divider(color: AppColors.divider, thickness: 1),
//
//             // Users list
//             Column(
//               children: widget.users.map((user) {
//                 final totalPercent =
//                 maxTotal > 0 ? user.total / maxTotal : 0.0;
//                 final ordersPercent =
//                 maxOrders > 0 ? user.orders.length / maxOrders : 0.0;
//
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // User name
//                       SizedBox(
//                         width: 100,
//                         child: Text(
//                           user.userName,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff605D64),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//
//                       // Bars stacked vertically
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Total bar with value
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: FractionallySizedBox(
//                                     widthFactor: totalPercent,
//                                     alignment: Alignment.centerLeft,
//                                     child: Container(
//                                       height: 12,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color(0xFF6A85F1),
//                                             Color(0xFF89C4F8),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   user.total.toString(),
//                                   style: const TextStyle(
//                                     fontSize: 10,
//                                     color: Color(0xff605D64),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             // Orders length bar with value
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: FractionallySizedBox(
//                                     widthFactor: ordersPercent,
//                                     alignment: Alignment.centerLeft,
//                                     child: Container(
//                                       height: 12,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color(0xffCBCBF6),
//                                             Color(0xffE0E0FA),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   user.orders.length.toString(),
//                                   style: const TextStyle(
//                                     fontSize: 10,
//                                     color: Color(0xff605D64),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

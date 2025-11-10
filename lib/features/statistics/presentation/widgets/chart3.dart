import 'package:crm/features/statistics/data/models/order_stat_model.dart';
import 'package:flutter/material.dart';

class StatsBarChart extends StatelessWidget {
  const StatsBarChart({
    super.key,
    required this.users,
    this.fixedMax, // optional fixed maximum
  });

  final List<OrdersByUser> users;
  final double? fixedMax;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return const SizedBox();

    // 1. Calculate max values from data
    final maxTotal = users.map((u) => u.total).fold<int>(0, (p, e) => e > p ? e : p);
    final maxOrders = users.map((u) => u.orders.length).fold<int>(0, (p, e) => e > p ? e : p);
    final dynamicMax = (maxTotal > maxOrders ? maxTotal : maxOrders).toDouble();

    // 2. Decide which max to use (fixed or dynamic)
    final globalMax = fixedMax != null && fixedMax! > 0 ? fixedMax! : dynamicMax;

    return Column(
      children: List.generate(users.length, (index) {
        final user = users[index];
        final mainValue = user.total;
     //   final subValue = user.orders.length;

        // 3. Percent scaling relative to global max
        final mainPercent = globalMax > 0 ? mainValue / globalMax : 0.0;
   //     final subPercent = globalMax > 0 ? subValue / globalMax : 0.0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username
              SizedBox(
                width: 100,
                child: Text(
                  user.userName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff605D64),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),

              // Values (total & orders length)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    mainValue.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                  // Text(
                  //   subValue.toString(),
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: Colors.grey[500],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(width: 8),

              // Bars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBar(mainPercent, const [Color(0xFF6A85F1), Color(0xFF89C4F8)]),
                  //  _buildBar(subPercent, const [Color(0xffCBCBF6), Color(0xffCBCBF6)]),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBar(double percent, List<Color> colors) {
    return FractionallySizedBox(
      widthFactor: percent,
      child: Container(
        height: 12,
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: colors),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}



///value data
// class StatsBarChart extends StatelessWidget {
//   const StatsBarChart({super.key, required this.users});
//
//   final List<OrdersByUser> users;
//
//   @override
//   Widget build(BuildContext context) {
//     final maxTotal = users
//         .map((u) => u.total)
//         .fold<int>(0, (a, b) => a > b ? a : b);
//
//     return Column(
//       children: List.generate(users.length, (index) {
//         final user = users[index];
//         final ordersLength = user.orders.length;
//
//         //  Calculate percents
//         final mainPercent = maxTotal > 0 ? user.total / maxTotal : 0.0;
//         final subPercent = maxTotal > 0 ? ordersLength / maxTotal : 0.0;
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // User Name
//               SizedBox(
//                 width: 100,
//                 child: Text(
//                   //item["name"],
//                   users[index].userName,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff605D64),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const SizedBox(width: 5),
//
//               // Values
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     users[index].total.toString(),
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                   Text(
//                     users[index].orders.length.toString(),
//                     style: TextStyle(fontSize: 10, color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 8),
//
//               // Bars
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildBar(mainPercent, const [
//                       Color(0xFF6A85F1),
//                       Color(0xFF89C4F8),
//                     ]),
//                     _buildBar(subPercent, [
//                       Color(0xffCBCBF6),
//                       Color(0xffCBCBF6),
//                     ]),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildBar(double percent, List<Color> colors) {
//     return FractionallySizedBox(
//       widthFactor: percent,
//       child: Container(
//         height: 12,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: LinearGradient(colors: colors),
//           boxShadow: [
//             BoxShadow(
//               color: colors.first.withOpacity(0.3),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:crm/core/constants/colors/app_colors.dart';
// import 'package:flutter/material.dart';
//
// class EmployeeActivityCard extends StatelessWidget {
//   const EmployeeActivityCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(9, 9, 9, 45),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(vertical: 50),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: AppColors.bgColor,
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   'Evan Yates',
//                   style: TextStyle(
//                     color: AppColors.darkBlue,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   'UI/UX Designer',
//                   style: TextStyle(
//                     color: AppColors.darkBlue,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 14),
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
//
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(color: AppColors.gray, width: 1),
//                   ),
//                   child: Text(
//                     'Middle',
//                     style: TextStyle(
//                       color: AppColors.gray,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       '16',
//                       style: TextStyle(
//                         color: AppColors.darkBlue,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 26,
//                       ),
//                     ),
//                     Text(
//                       'В ожидании',
//                       style: TextStyle(
//                         color: AppColors.gray,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '16',
//                       style: TextStyle(
//                         color: AppColors.darkBlue,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 26,
//                       ),
//                     ),
//                     Text(
//                       'В процессе',
//                       style: TextStyle(
//                         color: AppColors.gray,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '6',
//                       style: TextStyle(
//                         color: AppColors.darkBlue,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 26,
//                       ),
//                     ),
//                     Text(
//                       'Завершены',
//                       style: TextStyle(
//                         color: AppColors.gray,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

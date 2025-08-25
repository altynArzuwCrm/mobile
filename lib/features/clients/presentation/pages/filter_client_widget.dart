// import 'package:crm/common/widgets/main_btn.dart';
// import 'package:crm/common/widgets/shimmer_image.dart';
// import 'package:crm/common/widgets/textfield_title.dart';
// import 'package:crm/core/constants/colors/app_colors.dart';
// import 'package:crm/core/constants/strings/app_strings.dart';
// import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
// import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
// import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
// import 'package:crm/features/orders/presentation/widgets/search_chip.dart';
// import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
// import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
// import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/material.dart';


//
// class ClientFilterWidget extends StatefulWidget {
//   const ClientFilterWidget({super.key});
//
//   @override
//   State<ClientFilterWidget> createState() => _ClientFilterWidgetState();
// }
// class _ClientFilterWidgetState extends State<ClientFilterWidget> {
//
//
//
//   String? selectedSortField;
//   bool isAscending = true;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return DialogWidget(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           /// Title
//           Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 10),
//             child: BottomSheetTitle(title: AppStrings.filter),
//           ),
//           Divider(color: AppColors.divider, thickness: 1),
//
//           Flexible(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//
//                 children: [
//
//                   SizedBox(height: 15),
//
//                   /// ✅ Sort by field
//                   TextFieldTitle(
//                     title: "Sort by",
//                     child: CustomDropdownField(
//                       padding: EdgeInsets.zero,
//                       value: selectedSortField,
//                       hintText: "Choose field",
//                       onChanged: (val) {
//                         setState(() {
//                           selectedSortField = val;
//                         });
//                       },
//                       items: const [
//                         DropdownMenuItem(value: "name", child: Text("Name")),
//                         DropdownMenuItem(value: "date", child: Text("Date")),
//                         DropdownMenuItem(value: "company", child: Text("Company")),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   /// ✅ Sort order (ASC / DESC)
//                   TextFieldTitle(
//                     title: "Sort order",
//                     child: Row(
//                       children: [
//                         ChoiceChip(
//                           label: Text("ASC"),
//                           selected: isAscending,
//                           selectedColor: AppColors.primary,
//                           labelStyle: TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w400),
//
//                           onSelected: (val) {
//                             setState(() => isAscending = true);
//                           },
//                         ),
//                         SizedBox(width: 10),
//                         ChoiceChip(
//                           label: Text("DESC"),
//                           labelStyle: TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w400),
//                           selected: !isAscending,
//                           selectedColor: AppColors.primary,
//                           onSelected: (val) {
//                             setState(() => isAscending = false);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Divider(color: AppColors.divider, thickness: 1),
//
//                   SizedBox(height: 25),
//                 ],
//               ),
//             ),
//           ),
//
//           /// ✅ Apply filter button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: MainButton(
//               buttonTile: AppStrings.filter,
//               onPressed: () {
//                 debugPrint("Sort Field: $selectedSortField");
//                 debugPrint("Ascending: $isAscending");
//               },
//               isLoading: false,
//             ),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }

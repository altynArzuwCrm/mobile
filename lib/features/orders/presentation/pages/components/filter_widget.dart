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
//
// class FilterWidget extends StatefulWidget {
//   const FilterWidget({super.key});
//
//   @override
//   State<FilterWidget> createState() => _FilterWidgetState();
// }
//
// class _FilterWidgetState extends State<FilterWidget> {
//   bool _isExpanded = false;
//   final bool _isAdded = false;
//
//   void _toggleExpanded() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }
//
//   final TextEditingController _searchCtrl = TextEditingController();
//   String? selectedCategory;
//
//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final visibleCount = _isExpanded ? 10 : 5;
//
//     return DialogWidget(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 10),
//             child: BottomSheetTitle(title: AppStrings.filter),
//           ),
//           Divider(color: AppColors.divider, thickness: 1),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                   children: [
//                     SizedBox(height: 15),
//                     TextFieldTitle(
//                       title: AppStrings.dedline,
//                       child: SelectDateWidget(
//                         includeTime: true,
//                         dateFormat: 'dd MMMM yyyy, HH:mm',
//                         //  locale: const Locale('ru'),
//                         onDateSelected: (date) {
//                           debugPrint('Selected: $date');
//                         },
//                       ),
//                     ),
//
//                     SizedBox(height: 40),
//                     Divider(color: AppColors.divider, thickness: 1),
//                     SizedBox(height: 25),
//
//                     TextFieldTitle(
//                       title: AppStrings.responsible,
//                       padding: EdgeInsets.zero,
//                       bottomHeight: 20,
//                       child: ListView.builder(
//                         itemCount: visibleCount,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 20.0),
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {},
//                                   child: Container(
//                                     height: 24,
//                                     width: 24,
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(4),
//                                       border: Border.all(color: AppColors.accent),
//                                     ),
//                                     child: _isAdded
//                                         ? Icon(
//                                             Icons.done,
//                                             color: AppColors.primary,
//                                             size: 16,
//                                           )
//                                         : null,
//                                   ),
//                                 ),
//                                 SizedBox(width: 17),
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: ImageWithShimmer(
//                                     height: 24,
//                                     width: 24,
//                                     imageUrl: img,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   'Oscar Holloway',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16,
//                                     color: AppColors.accent,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: _toggleExpanded,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             _isExpanded ? AppStrings.less : AppStrings.more,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Icon(
//                             _isExpanded
//                                 ? Icons.keyboard_arrow_up_outlined
//                                 : Icons.keyboard_arrow_down_outlined,
//                             color: AppColors.primary,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Divider(color: AppColors.divider, thickness: 1),
//                     SizedBox(height: 25),
//
//                     ///client
//                     TextFieldTitle(
//                       title: AppStrings.customer,
//                       child: HomePageSearchWidget(
//                         searchCtrl: _searchCtrl,
//                         onSearch: () {
//                           setState(() {});
//                         },
//                         onClear: () {
//                           setState(() {});
//                           _searchCtrl.clear();
//                           FocusManager.instance.primaryFocus?.unfocus();
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 15),
//
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 0,
//                       children: List.generate(
//                         3,
//                         (e) => SearchChip(
//                           title: 'Violet R',
//                           onTap: () {},
//                           onDeleted: () {},
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Divider(color: AppColors.divider, thickness: 1),
//                     SizedBox(height: 25),
//
//                     ///stadiya
//                     TextFieldTitle(
//                       title: AppStrings.stage,
//                       child: CustomDropdownField(
//                         padding: EdgeInsets.zero,
//                         value: selectedCategory,
//                         onChanged: (val) {
//                           setState(() {
//                             selectedCategory = val;
//                           });
//                         },
//                         hintText: AppStrings.placeOrder,
//
//                         items: const [
//                           DropdownMenuItem(value: 'a', child: Text("Moscow")),
//                           DropdownMenuItem(value: 'l', child: Text("GB")),
//                           DropdownMenuItem(value: 'm', child: Text("USA")),
//                           DropdownMenuItem(value: 'b', child: Text("Minsk")),
//                           DropdownMenuItem(value: 'd', child: Text("London")),
//                           DropdownMenuItem(value: 'ah', child: Text("Paris")),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 45),
//
//                     ///Просрочено
//                     TextFieldTitle(
//                       title: AppStrings.overdue,
//                       child: CustomDropdownField(
//                         padding: EdgeInsets.zero,
//
//                         value: selectedCategory,
//                         onChanged: (val) {
//                           setState(() {
//                             selectedCategory = val;
//                           });
//                         },
//                         hintText: AppStrings.placeOrder,
//                         items: const [
//                           DropdownMenuItem(value: 'a', child: Text("Moscow")),
//                           DropdownMenuItem(value: 'l', child: Text("GB")),
//                           DropdownMenuItem(value: 'm', child: Text("USA")),
//                           DropdownMenuItem(value: 'b', child: Text("Minsk")),
//                           DropdownMenuItem(value: 'd', child: Text("London")),
//                           DropdownMenuItem(value: 'ah', child: Text("Paris")),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 45),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.info, color: AppColors.primary),
//                         SizedBox(width: 10),
//                         Text(
//                           'найдено 10 совпадений',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: AppColors.accent,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 25),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: MainButton(
//               buttonTile: AppStrings.filter,
//               onPressed: () {},
//               isLoading: false,
//             ),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }

import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/stages/presentation/cubits/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'custom_dropdown.dart';
import 'custom_radio_btn.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.hasSelected = false,
    required this.model,
  });

  final void Function()? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool hasSelected;
  final OrderModel model;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String? selectedStage;

  @override
  void initState() {
    super.initState();
    selectedStage = widget.model.stage?.name; // Initial value from order API
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.hasSelected ? widget.onTap : null,
      onLongPress: !widget.hasSelected ? widget.onLongPress : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.isSelected ? AppColors.lightBlue : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<StageCubit, StageState>(
                  builder: (context, state) {
                    if (state is StageLoaded) {
                      return CustomDropdown(
                        value: selectedStage,
                        hintText: widget.model.stage?.displayName,
                        items: state.data
                            .map(
                              (stage) => DropdownMenuItem(
                            value: stage.name,
                            child: Text(stage.displayName),
                          ),
                        )
                            .toList(),
                        onChanged: (val) {
                          setState(() => selectedStage = val);

                          // Optionally, call update API here
                          // context.read<OrderDetailCubit>().updateOrder(
                          //   CreateOrderParams(
                          //     id: widget.model.id,
                          //     stageName: val,
                          //   ),
                          // );
                        },
                      );
                    }
                    return const SizedBox(
                      height: 40,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
                widget.hasSelected
                    ? CustomRadioButton(isSelected: widget.isSelected)
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 5),
            // ...rest of your UI
          ],
        ),
      ),
    );
  }
}


//
// class OrderCard extends StatefulWidget {
//   const OrderCard({
//     super.key,
//
//     this.onTap,
//     this.onLongPress,
//     this.isSelected = false,
//     this.hasSelected = false,
//     required this.model,
//   });
//
//   final void Function()? onTap;
//   final VoidCallback? onLongPress;
//   final bool isSelected;
//   final bool hasSelected;
//   final OrderModel model;
//
//   @override
//   State<OrderCard> createState() => _OrderCardState();
// }
//
// class _OrderCardState extends State<OrderCard> {
//   @override
//   Widget build(BuildContext context) {
//
//     return GestureDetector(
//       onTap: () {
//         if (widget.hasSelected && widget.onTap != null) {
//           widget.onTap!();
//         } else {}
//       },
//       onLongPress: () {
//         if (!widget.hasSelected && widget.onLongPress != null) {
//           widget.onLongPress!();
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           color: (widget.isSelected) ? AppColors.lightBlue : AppColors.white,
//         ),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               // mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BlocBuilder<StageCubit, StageState>(
//                   builder: (context, state) {
//                     if (state is StageLoaded) {
//                       return CustomDropdown(
//                         value: state.selectedCategory,
//                         onChanged: (val) {
//                           locator<StageCubit>().selectCategory(val);
//
//                         },
//                         hintText: widget.model.stage?.displayName,
//
//                         items: state.data
//                             .map(
//                               (stage) => DropdownMenuItem(
//                                 value: stage.name,
//                                 child: Text(stage.displayName),
//                               ),
//                             )
//                             .toList(),
//                       );
//                     } else {
//                       return CustomDropdown(
//                         value: null,
//                         onChanged: (val) {},
//                         hintText: widget.model.stage?.displayName,
//                         items: [],
//                       );
//                     }
//                   },
//                 ),
//
//                 widget.hasSelected
//                     ? CustomRadioButton(isSelected: widget.isSelected)
//                     : SizedBox.shrink(),
//               ],
//             ),
//             SizedBox(height: 5),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.model.project?.title ?? '',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                     color: AppColors.darkBlue,
//                   ),
//                 ),
//                 Text(
//                   AppStrings.project,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     color: AppColors.normalGray,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5),
//             Divider(color: AppColors.divider, thickness: 1),
//             SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       AppStrings.start,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: AppColors.normalGray,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       '2d 4h',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         color: AppColors.darkBlue,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Column(
//                 //   children: [
//                 //     Text(
//                 //       AppStrings.responsible,
//                 //       style: TextStyle(
//                 //         fontWeight: FontWeight.w400,
//                 //         fontSize: 14,
//                 //         color: AppColors.normalGray,
//                 //       ),
//                 //     ),
//                 //     SizedBox(height: 2),
//                 //
//                 //     Text(
//                 //       'Марал Маралова',
//                 //       style: TextStyle(
//                 //         fontWeight: FontWeight.w400,
//                 //         fontSize: 12,
//                 //         color: AppColors.accent,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 Column(
//                   children: [
//                     Text(
//                       AppStrings.dedline,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: AppColors.normalGray,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//
//                     Text(
//                       widget.model.deadline,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         color: AppColors.darkBlue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 5),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // DecoratedContainer(
//                 //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//                 //   strokeWidth: 1,
//                 //   dashSpace: 1,
//                 //   dashWidth: 1,
//                 //   cornerRadius: null,
//                 //   strokeColor: AppColors.black,
//                 //   child: Text(
//                 //     'В работе',
//                 //     style: TextStyle(
//                 //       fontWeight: FontWeight.w400,
//                 //       fontSize: 12,
//                 //       color: AppColors.black,
//                 //     ),
//                 //   ),
//                 // ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGreen,
//
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     AppStrings.acceptJob,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                       color: AppColors.green,
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(
//                       color: AppColors.red,
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                   child: Text(
//                     AppStrings.reject,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                       color: AppColors.red,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     context.push(
//                       '${AppRoutes.orderDetails}/${widget.model.id}',
//                     );
//                   },
//                   child: Text(
//                     AppStrings.moreDetails,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

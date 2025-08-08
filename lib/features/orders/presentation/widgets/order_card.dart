import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';
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
  });

  final void Function()? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool hasSelected;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    String? selectedCategory;

    return GestureDetector(
      onTap: () {
        if (widget.hasSelected && widget.onTap != null) {
          widget.onTap!();
        } else {}
      },
      onLongPress: () {
        if (!widget.hasSelected && widget.onLongPress != null) {
          widget.onLongPress!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: (widget.isSelected) ? AppColors.lightBlue : AppColors.white,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdown(
                  value: selectedCategory,
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                  hintText: 'Дизайн',

                  items: const [
                    DropdownMenuItem(value: 'a', child: Text("Moscow")),
                    DropdownMenuItem(value: 'l', child: Text("GB")),
                    DropdownMenuItem(value: 'm', child: Text("USA")),
                  ],
                ),

                widget.hasSelected
                    ? CustomRadioButton(isSelected: widget.isSelected)
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.orderTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ),
                Text(
                  AppStrings.project,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.normalGray,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(color: AppColors.divider, thickness: 1),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '2d 4h',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      AppStrings.responsible,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 2),

                    Text(
                      'Марал Маралова',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      AppStrings.dedline,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.normalGray,
                      ),
                    ),
                    SizedBox(height: 2),

                    Text(
                      '1d 2h',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DecoratedContainer(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                //   strokeWidth: 1,
                //   dashSpace: 1,
                //   dashWidth: 1,
                //   cornerRadius: null,
                //   strokeColor: AppColors.black,
                //   child: Text(
                //     'В работе',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w400,
                //       fontSize: 12,
                //       color: AppColors.black,
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,

                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    AppStrings.acceptJob,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.green,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.red,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    AppStrings.reject,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.push(AppRoutes.details);
                  },
                  child: Text(
                    AppStrings.moreDetails,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

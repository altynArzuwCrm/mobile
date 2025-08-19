import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/orders/presentation/widgets/widget_model/order_item_model.dart';

import 'package:flutter/material.dart';

class NewOrderItem extends StatelessWidget {
  const NewOrderItem({super.key, required this.item, required this.onRemove});

  final OrderItemModel item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.timeBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///3 product
          TextFieldTitle(
            title: AppStrings.product,
            child: KTextField(
              controller: item.productCtrl,
              // _productCtrl,
              isSubmitted: false,
              hintText: '',
              hintStyle: TextStyle(
                color: AppColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              borderColor: AppColors.timeBorder,
            ),
          ),
          //count
          SizedBox(height: 20),
          TextFieldTitle(
            title: AppStrings.count,
            child: KTextField(
              controller: item.countCtrl,
              //_countCtrl,
              isSubmitted: false,
              hintText: '',
              keyboardType: TextInputType.number,
              hintStyle: TextStyle(
                color: AppColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              borderColor: AppColors.timeBorder,
            ),
          ),

          //4 price
          SizedBox(height: 20),

          TextFieldTitle(
            title: AppStrings.sum,
            child: KTextField(
              controller: item.priceCtrl,
              //_priceCtrl,
              isSubmitted: false,
              hintText: '',
              keyboardType: TextInputType.number,

              hintStyle: TextStyle(
                color: AppColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              borderColor: AppColors.timeBorder,
            ),
          ),

          //6 deadline
          SizedBox(height: 20),

          TextFieldTitle(
            title: AppStrings.dedline,
            child: SelectDateWidget(
              includeTime: true,
              dateFormat: 'dd MMMM yyyy, HH:mm',
              //  locale: const Locale('ru'),
              onDateSelected: (date) {
                debugPrint('Selected: $date');
                item.deadline = date;
              },
            ),
          ),

          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }
}

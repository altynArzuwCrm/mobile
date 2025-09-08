import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_selector.dart';

class SingleOrderItem extends StatelessWidget {
  const SingleOrderItem({
    super.key,
    required this.onSelectDate,
    required this.priceCtrl,
    required this.countCtrl,
    required this.onSelectProduct,
    required this.onAddProduct,
    required this.formKey,
  });

  final TextEditingController priceCtrl;
  final TextEditingController countCtrl;
  final ValueChanged onSelectDate;
  final ValueChanged onSelectProduct;
  final GlobalKey<FormState> formKey;
  final VoidCallback onAddProduct;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),

          ///3 product
          TextFieldTitle(
            title: AppStrings.product,
            child: BlocProvider.value(
              value: locator<ProductsCubit>(),
              child: Row(
                children: [
                  Expanded(
                    child: ProductSelector(
                      onSelectProduct: (value) {
                        onSelectProduct(value);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.bgColor,
                    ),
                    child: IconButton(
                      onPressed: onAddProduct,
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //count
          SizedBox(height: 20),
          TextFieldTitle(
            title: AppStrings.count,
            child: KTextField(
              controller: countCtrl,
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
              controller: priceCtrl,
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
          SizedBox(height: 30),

          TextFieldTitle(
            title: AppStrings.dedline,
            child: SelectDateWidget(
              includeTime: true,
              dateFormat: 'dd MMMM yyyy, HH:mm',
              //  locale: const Locale('ru'),
              onDateSelected: onSelectDate,
            ),
          ),
        ],
      ),
    );
  }
}

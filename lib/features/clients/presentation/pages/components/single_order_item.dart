import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleOrderItem extends StatelessWidget {
  const SingleOrderItem({
    super.key,
    required this.onSelectDate,
    required this.priceCtrl,
    required this.countCtrl,
    required this.productCtrl,
    required this.onSelectProduct,
  });

  final TextEditingController priceCtrl;
  final TextEditingController countCtrl;
  final TextEditingController productCtrl;
  final ValueChanged onSelectDate;
  final ValueChanged onSelectProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        ///3 product
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldTitle(
              title: AppStrings.product,
              child: BlocProvider.value(
                value: locator<ProductsCubit>(),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    final inputDecoration = InputDecoration(
                      hintText: state is ProductsLoading
                          ? "Loading projects..."
                          : state is ClientsError
                          ? "Failed to load"
                          : "Select product",
                      //    filled: true,
                      //      fillColor: AppColors.white,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.gray,
                        size: 30,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.timeBorder,
                          // highlight color when focused
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.timeBorder,
                          // highlight color when focused
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.timeBorder,
                          width: 1,
                        ),
                      ),
                    );

                    if (state is ProductsLoaded) {
                      return EasyAutocomplete(
                        suggestions: state.data.map((c) => c.name).toList(),
                        initialValue: '',
                        onChanged: (value) {
                          final matches = state.data
                              .where((c) => c.name == value)
                              .toList();
                          if (matches.isNotEmpty) {
                            final client = matches.first;
                            //  clientsCubit.selectClient(client.id.toString());
                            // selectedProductId = client.id.toString();
                            onSelectProduct(client.id.toString());
                          } else {
                            // selectedProductId = null;
                            onSelectProduct(null);
                          }
                        },

                        validator: (v) {
                          if (v == null) {
                            return 'Выберите проект';
                          }
                          return null;
                        },
                        decoration: inputDecoration,
                      );
                    } else {
                      return IgnorePointer(
                        ignoring: true,
                        child: EasyAutocomplete(
                          suggestions: const <String>[],
                          initialValue: '',
                          onChanged: (_) {},
                          decoration: inputDecoration,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
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
            //     (date) {
            //   debugPrint('Selected: $date');
            //   item.deadline = date;
            // },
          ),
        ),
      ],
    );
  }
}

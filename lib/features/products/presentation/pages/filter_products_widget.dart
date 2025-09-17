import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/sort_order_button.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterProductsWidget extends StatefulWidget {
  const FilterProductsWidget({
    super.key,
    required this.initialSortOrder,
    required this.sortBy,
  });

  final String? sortBy;
  final String initialSortOrder;

  @override
  State<FilterProductsWidget> createState() => _FilterProductsWidgetState();
}

class _FilterProductsWidgetState extends State<FilterProductsWidget> {
  late String sortOrder;
  late String? selectedSortBy;

  @override
  void initState() {
    super.initState();
    sortOrder = widget.initialSortOrder;
    selectedSortBy = widget.sortBy;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      insetPadding: const EdgeInsets.symmetric(horizontal: 22),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.filter),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CategoryBtn(
                    title: "По название",
                    isSelected: selectedSortBy == 'name',
                    onTap: () {
                      setState(() {
                        selectedSortBy = 'name';
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CategoryBtn(
                    title: "По времени",
                    isSelected: selectedSortBy == 'created_at',
                    onTap: () {
                      setState(() {
                        selectedSortBy = 'created_at';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SortOrderSelector(
              sortOrder: sortOrder,
              onChanged: (val) {
                setState(() => sortOrder = val);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainButton(
              buttonTile: AppStrings.filter,
              onPressed: () {
                final params = ProductParams(
                  sortProduct: sortOrder,
                  sortBy: selectedSortBy,
                  page: 1,
                );
                locator<ProductsCubit>().getAllProducts(params);
                context.pop(sortOrder);
              },
              isLoading: false,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

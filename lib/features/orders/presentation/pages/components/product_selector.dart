import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSelector extends StatelessWidget {
  const ProductSelector({super.key, required this.onSelectProduct});

  final ValueChanged onSelectProduct;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final inputDecoration = InputDecoration(
          hintText: state is ProductsLoading
              ? "Loading products..."
              : state is ProductsError
              ? "Failed to load"
              : "Select product",
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
            borderSide: const BorderSide(color: AppColors.timeBorder, width: 1),
          ),
        );
        if (state is! ProductsLoaded) {
          return IgnorePointer(
            ignoring: true,
            child: EasyAutocomplete(
              suggestions: const <String>[],
              initialValue: '',
              onChanged: (_) {},
              decoration: inputDecoration,
            ),
          );
        } else {
          return EasyAutocomplete(
            suggestions: state.data.map((c) => c.name).toList(),
            initialValue: '',
            onChanged: (value) {
              final matches = state.data.where((c) => c.name == value).toList();
              if (matches.isNotEmpty) {
                final product = matches.first;
                onSelectProduct(product.id.toString());
              } else {
                onSelectProduct(null);
              }
            },
            validator: (v) {
              if (v == null) {
                return 'Выберите продукт';
              }
              return null;
            },
            decoration: inputDecoration,
          );
        }
      },
    );
  }
}

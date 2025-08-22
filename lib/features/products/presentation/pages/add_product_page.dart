import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameCtrl.clear();
    _descriptionCtrl.clear();
    _priceCtrl.clear();

    // clientsCubit.selectClient(null);
  }

  void _onSubmit() {
    final isValid = formKey.currentState?.validate() ?? false;

    final newProduct = CreateProductParams(
      name: '',
      description: '',
      category: '',
      price: 0,
    );

    // locator<ProductsCubit>().createProduct(newProduct);

    _resetForm();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.addProject),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),

                      TextFieldTitle(
                        title: AppStrings.projectTitle,
                        child: KTextField(
                          controller: _nameCtrl,
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

                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.description,
                        child: KTextField(
                          controller: _descriptionCtrl,
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

                      SizedBox(height: 20),

                      Divider(color: AppColors.divider, thickness: 1),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: _onSubmit,
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

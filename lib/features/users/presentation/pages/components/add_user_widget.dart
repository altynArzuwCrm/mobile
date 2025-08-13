import 'package:crm/common/widgets/k_textfield.dart' show KTextField;
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({super.key});

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _companyNameCtrl = TextEditingController();

  String? selectedCategory;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _companyNameCtrl.dispose();
    super.dispose();
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
            child: BottomSheetTitle(title: AppStrings.addUser),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),

                    TextFieldTitle(
                      title: AppStrings.name,
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

                    //2
                    SizedBox(height: 30),
                    TextFieldTitle(
                      title: AppStrings.phone,
                      child: KTextField(
                        controller: _phoneCtrl,
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

                    //3
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.email,
                      child: KTextField(
                        controller: _emailCtrl,
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

                    //4
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.password,
                      child: KTextField(
                        controller: _passwordCtrl,
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

                    //5
                    SizedBox(height: 30),
                    TextFieldTitle(
                      title: AppStrings.company,
                      child: KTextField(
                        controller: _companyNameCtrl,
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

                    SizedBox(height: 10),
                    Divider(color: AppColors.divider, thickness: 1),


                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: () {},
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';


class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({super.key});

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  final TextEditingController _priceCtrl = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.addOrder),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),

                    TextFieldTitle(
                      title: AppStrings.customer,
                      child: CustomDropdownField(
                        padding: EdgeInsets.zero,
                        value: selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory = val;
                          });
                        },
                        hintText: 'Evan Yates',
                        items: const [
                          DropdownMenuItem(value: 'a', child: Text("Moscow")),
                          DropdownMenuItem(value: 'l', child: Text("GB")),
                          DropdownMenuItem(value: 'm', child: Text("USA")),
                          DropdownMenuItem(value: 'b', child: Text("Minsk")),
                          DropdownMenuItem(value: 'd', child: Text("London")),
                          DropdownMenuItem(value: 'ah', child: Text("Paris")),
                        ],
                      ),
                    ),

                    //2
                    SizedBox(height: 30),
                    TextFieldTitle(
                      title: AppStrings.project,
                      child: CustomDropdownField(
                        padding: EdgeInsets.zero,
                        value: selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory = val;
                          });
                        },
                        hintText: 'PN0001245',
                        items: const [
                          DropdownMenuItem(value: 'a', child: Text("Moscow")),
                          DropdownMenuItem(value: 'l', child: Text("GB")),
                          DropdownMenuItem(value: 'm', child: Text("USA")),
                          DropdownMenuItem(value: 'b', child: Text("Minsk")),
                          DropdownMenuItem(value: 'd', child: Text("London")),
                          DropdownMenuItem(value: 'ah', child: Text("Paris")),
                        ],
                      ),
                    ),

                    //3
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.responsible,
                      child: CustomDropdownField(
                        padding: EdgeInsets.zero,
                        value: selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory = val;
                          });
                        },
                        hintText: 'Blake Silva',
                        items: const [
                          DropdownMenuItem(value: 'a', child: Text("Moscow")),
                          DropdownMenuItem(value: 'l', child: Text("GB")),
                          DropdownMenuItem(value: 'm', child: Text("USA")),
                          DropdownMenuItem(value: 'b', child: Text("Minsk")),
                          DropdownMenuItem(value: 'd', child: Text("London")),
                          DropdownMenuItem(value: 'ah', child: Text("Paris")),
                        ],
                      ),
                    ),

                    //4
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.sum,
                      child: KTextField(
                        controller: _priceCtrl,
                        isSubmitted: false,
                        hintText: '2500тмт',
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
                      title: AppStrings.start,
                      child: SelectDateWidget(
                        includeTime: true,
                        dateFormat: 'dd MMMM yyyy, HH:mm',
                        //  locale: const Locale('ru'),
                        onDateSelected: (date) {
                          debugPrint('Selected: $date');
                        },
                      ),
                    ),

                    //6
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.dedline,
                      child: SelectDateWidget(
                        includeTime: true,
                        dateFormat: 'dd MMMM yyyy, HH:mm',
                        //  locale: const Locale('ru'),
                        onDateSelected: (date) {
                          debugPrint('Selected: $date');
                        },
                      ),
                    ),

                    SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Товары',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.darkBlue,
                            ),
                          ),

                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.bgColor,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Divider(color: AppColors.divider, thickness: 1),
                    SizedBox(height: 25),


                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

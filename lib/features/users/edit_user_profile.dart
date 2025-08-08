import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmployeeProfileEditPage extends StatefulWidget {
  const EmployeeProfileEditPage({super.key});

  @override
  State<EmployeeProfileEditPage> createState() =>
      _EmployeeProfileEditPageState();
}

class _EmployeeProfileEditPageState extends State<EmployeeProfileEditPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _surnameCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _numberCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _positionCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _numberCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.general,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkBlue,
                  ),
                ),

                SizedBox(height: 15),
                CustomTextFieldWithTitle(
                  controller: _nameCtrl,
                  title: AppStrings.name,
                  hintText: 'Иван',
                ),
                SizedBox(height: 20),
                CustomTextFieldWithTitle(
                  controller: _surnameCtrl,
                  title: AppStrings.surname,
                  hintText: 'Иванов',
                ),
                SizedBox(height: 20),
                CustomTextFieldWithTitle(
                  controller: _positionCtrl,
                  title: AppStrings.position,
                  hintText: 'UI/UX Designer',
                ),
                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        AppStrings.company,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),

                    CustomDropdownField(
                      value: selectedCategory,
                      onChanged: (val) {
                        setState(() {
                          selectedCategory = val;
                        });
                      },
                      padding: EdgeInsets.zero,
                      hintText: 'Cadabra',
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.gray,
                        size: 30,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'a', child: Text("Moscow")),
                        DropdownMenuItem(value: 'l', child: Text("GB")),
                        DropdownMenuItem(value: 'm', child: Text("USA")),
                        DropdownMenuItem(value: 'b', child: Text("Minsk")),
                        DropdownMenuItem(value: 'd', child: Text("London")),
                        DropdownMenuItem(value: 'ah', child: Text("Paris")),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),
                CustomTextFieldWithTitle(
                  controller: _surnameCtrl,
                  title: AppStrings.location,
                  hintText: 'NYC, New York, USA',
                  suffixIcon: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.gray,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        AppStrings.birthday,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    SelectDateWidget(
                      includeTime: true,
                      dateFormat: 'dd MMMM yyyy, HH:mm',
                      //  locale: const Locale('ru'),
                      onDateSelected: (date) {
                        debugPrint('Selected: $date');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  AppStrings.contacts,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkBlue,
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFieldWithTitle(
                  controller: _emailCtrl,
                  title: AppStrings.email,
                  hintText: 'evanyates@gmail.com',
                ),
                SizedBox(height: 20),
                CustomTextFieldWithTitle(
                  controller: _numberCtrl,
                  title: AppStrings.number,
                  hintText: '+1 675 346 23-10',
                ),
                SizedBox(height: 35),
                MainButton(
                  buttonTile: AppStrings.save,
                  onPressed: () {},
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

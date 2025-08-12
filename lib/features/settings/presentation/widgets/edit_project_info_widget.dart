import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProjectInfoWidget extends StatefulWidget {
  const EditProjectInfoWidget({super.key});

  @override
  State<EditProjectInfoWidget> createState() => _EditProjectInfoWidgetState();
}

class _EditProjectInfoWidgetState extends State<EditProjectInfoWidget> {
  final TextEditingController _priceCtrl = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allInfo,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  'Клиент',
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
                hintText: 'Evan Yates',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  AppStrings.sum,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.gray,
                  ),
                ),
              ),
              SizedBox(height: 7),

              KTextField(
                controller: _priceCtrl,
                isSubmitted: false,
                hintText: '2500тмт',
                hintStyle: TextStyle(
                  color: AppColors.gray,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                borderColor: AppColors.timeBorder,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  AppStrings.dedline,
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

          Row(
            children: [
              SvgPicture.asset(
                IconAssets.calendar,
                width: 22,
                height: 20,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 24),
              Text(
                'Created May 28, 2020',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

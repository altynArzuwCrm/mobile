import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';

class ProfileDataEditPage extends StatefulWidget {
  const ProfileDataEditPage({super.key});

  @override
  State<ProfileDataEditPage> createState() => _ProfileDataEditPageState();
}

class _ProfileDataEditPageState extends State<ProfileDataEditPage> {

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _surnameCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _numberCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _positionCtrl.dispose();
    _emailCtrl.dispose();
    _numberCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профиль'),
        actions: [
          AppBarIcon(onTap: () {}, icon: IconAssets.edit),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Сумма',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 7),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: KTextField(
                    controller:_nameCtrl,
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
                ),
              ],
            ),

            //5
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Начало',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectDateWidget(
                    includeTime: true,
                    dateFormat: 'dd MMMM yyyy, HH:mm',
                    //  locale: const Locale('ru'),
                    onDateSelected: (date) {
                      print('Selected: $date');
                    },
                  ),
                ),
              ],
            ),

            //6
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Дедлайн',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SelectDateWidget(
                    includeTime: true,
                    dateFormat: 'dd MMMM yyyy, HH:mm',
                    //  locale: const Locale('ru'),
                    onDateSelected: (date) {
                      print('Selected: $date');
                    },
                  ),
                ),
              ],
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
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MainButton(
                buttonTile: 'Создать',
                onPressed: () {},
                isLoading: false,
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),

    );
  }
}

import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Профиль'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppBarIcon(onTap: () {}, icon: IconAssets.edit),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Общее',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkBlue,
                  ),
                ),

                SizedBox(height: 2),
                ProfileItemWidget(title: 'Имя', name: 'Иван'),
                SizedBox(height: 20),
                ProfileItemWidget(title: 'Фамилия', name: 'Иванов'),
                SizedBox(height: 20),
                ProfileItemWidget(title: 'Позиция', name: 'UI/UX Designer'),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: 'Дата рождения',
                  name: 'May 19, 1996',
                  showDate: true,
                ),
                SizedBox(height: 35),
                Text(
                  'Контакты',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkBlue,
                  ),
                ),
                SizedBox(height: 4),
                ProfileItemWidget(title: 'Email', name: 'evanyates@gmail.com'),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: 'Номер телефона',
                  name: '+1 675 346 23-10',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

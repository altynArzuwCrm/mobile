import 'package:crm/common/widgets/appbar_icon.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/assets_manager.dart';
import 'package:crm/features/details/presentation/widgets/main_card.dart';
import 'package:crm/features/settings/presentation/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactDetailPage extends StatelessWidget {
  const ContactDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.contactInfo),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppBarIcon(
              onTap: () {
                context.push(AppRoutes.editContact);
              },
              icon: IconAssets.edit,
            ),
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
                  AppStrings.general,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkBlue,
                  ),
                ),

                SizedBox(height: 15),
                ProfileItemWidget(title: AppStrings.name, name: 'Иван'),
                SizedBox(height: 20),
                ProfileItemWidget(title: AppStrings.surname, name: 'Иванов'),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: AppStrings.position,
                  name: 'UI/UX Designer',
                ),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: AppStrings.company,
                  name: 'Cadabra',
                  showDate: true,
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.gray,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: AppStrings.location,
                  name: 'NYC, New York, USA',
                  showDate: true,
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.gray,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: AppStrings.birthday,
                  name: 'May 19, 1996',
                  showDate: true,
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
                ProfileItemWidget(
                  title: AppStrings.email,
                  name: 'evanyates@gmail.com',
                ),
                SizedBox(height: 20),
                ProfileItemWidget(
                  title: AppStrings.number,
                  name: '+1 675 346 23-10',
                ),
                SizedBox(height: 35),
                MainButton(
                  buttonTile: AppStrings.back,
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

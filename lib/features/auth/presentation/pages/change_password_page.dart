import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Altyn Arzuw',

            style: TextStyle(
              fontFamily: TextFonts.nunito,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 60),
          BgCardWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Сбросить пароль',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: TextFonts.nunito,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      textAlign: TextAlign.start,

                      style: TextStyle(
                        fontFamily: TextFonts.nunito,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),

                    Form(
                      key: formKey,
                      child: KTextField(
                        controller: _emailCtrl,
                        isSubmitted: false,
                        hintText: 'youremail@gmail.com',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 53),
                MainButton(
                  buttonTile: 'Подтвердить',
                  onPressed: () {},
                  isLoading: false,
                  hasIcon: true,
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},

                  child: Text(
                    'Вернуться',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: TextFonts.nunito,

                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),

                ///
              ],
            ),
          ),
        ],
      ),
    );
  }
}

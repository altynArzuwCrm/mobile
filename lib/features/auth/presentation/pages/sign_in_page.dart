import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Altyn Arzuw',

            style: TextStyle(
              fontFamily: TextFonts.nunito,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 60),
          BgCardWidget(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Войти в портал',
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

                      KTextField(controller: _emailCtrl, isSubmitted: false),
                      SizedBox(height: 25),

                      Text(
                        'Пароль',
                        textAlign: TextAlign.start,

                        style: TextStyle(
                          fontFamily: TextFonts.nunito,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),

                      KTextField(controller: _passwordCtrl, isSubmitted: false, obscureText: isVisible,

                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: isVisible
                              ? const Icon(Icons.visibility_outlined,color: AppColors.white,)
                              : const Icon(Icons.visibility_off_outlined,color: AppColors.white,),
                        ),
                      ),
                      SizedBox(height: 17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  checkboxTheme: CheckboxThemeData(
                                    side: BorderSide(color: AppColors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>((
                                          states,
                                        ) {
                                          return Colors.transparent;
                                        }),
                                  ),
                                ),
                                child: Checkbox(
                                  value: true,
                                  onChanged: (value) {},
                                  checkColor: AppColors.primary,
                                ),
                              ),

                              SizedBox(width: 12),
                              Text(
                                'Запомнить',
                                textAlign: TextAlign.start,

                                style: TextStyle(
                                  fontFamily: TextFonts.nunito,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Забыли пароль?',
                            textAlign: TextAlign.end,

                            style: TextStyle(
                              fontFamily: TextFonts.nunito,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  MainButton(
                    buttonTile: 'Войти',
                    onPressed: () {},
                    isLoading: false,
                    hasIcon: true,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},

                    child: Text(
                      'Нет аккаунта?',
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
          ),
        ],
      ),
    );
  }
}

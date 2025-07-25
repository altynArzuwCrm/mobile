import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _surnameCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool isVisible = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _positionCtrl.dispose();
    _surnameCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      child: SingleChildScrollView(
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Заявка для регистрации',
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
                          'Имя',
                          textAlign: TextAlign.start,

                          style: TextStyle(
                            fontFamily: TextFonts.nunito,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        KTextField(
                          controller: _nameCtrl,
                          isSubmitted: false,
                          hintText: 'Введите ваше имя',
                        ),
                        SizedBox(height: 25),

                        Text(
                          'Фамилия',
                          textAlign: TextAlign.start,

                          style: TextStyle(
                            fontFamily: TextFonts.nunito,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        KTextField(
                          controller: _surnameCtrl,
                          isSubmitted: false,
                          hintText: 'Введите свою фамилию',
                        ),
                        SizedBox(height: 25),

                        Text(
                          'Позиция',
                          textAlign: TextAlign.start,

                          style: TextStyle(
                            fontFamily: TextFonts.nunito,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        KTextField(
                          controller: _positionCtrl,
                          isSubmitted: false,
                          hintText: 'Введите свою позицию',
                        ),
                        SizedBox(height: 25),

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

                        KTextField(
                          controller: _emailCtrl,
                          isSubmitted: false,
                          hintText: 'youremail@gmail.com',
                        ),
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

                        KTextField(
                          controller: _passwordCtrl,
                          isSubmitted: false,
                          obscureText: isVisible,

                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: isVisible
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    color: AppColors.white,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: AppColors.white,
                                  ),
                          ),
                          hintText: '••••••••',
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
                                          WidgetStateProperty.resolveWith<
                                            Color
                                          >((states) {
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
                      buttonTile: 'Отправитьh',
                      onPressed: () {},
                      isLoading: false,
                      hasIcon: true,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},

                      child: Text(
                        'Есть аккаунт',
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
      ),
    );
  }
}

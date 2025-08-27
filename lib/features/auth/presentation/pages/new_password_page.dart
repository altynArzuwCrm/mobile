import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  bool isVisible = true;
  bool isVisibleNew = true;

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.appName,

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
                    AppStrings.newPassword,
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
                        AppStrings.newPassword,
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
                        controller: _newPasswordCtrl,
                        isSubmitted: false,
                        obscureText: isVisibleNew,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: TextFonts.nunito,
                        ),
                        borderColor: AppColors.white,
                        hintStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: TextFonts.nunito,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleNew = !isVisibleNew;
                            });
                          },
                          child: isVisibleNew
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: AppColors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.white,
                                ),
                        ),
                      ),
                      SizedBox(height: 25),

                      Text(
                        AppStrings.confirmPassword,
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
                        controller: _confirmPasswordCtrl,
                        isSubmitted: false,
                        obscureText: isVisible,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: TextFonts.nunito,
                        ),
                        borderColor: AppColors.white,
                        hintStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: TextFonts.nunito,
                        ),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                  MainButton(
                    buttonTile: AppStrings.confirm,
                    onPressed: () {
                      context.go(AppRoutes.mainStatistics);
                    },
                    isLoading: false,
                    hasIcon: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

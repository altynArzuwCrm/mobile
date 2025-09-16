import 'dart:developer';

import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:crm/core/utils/fcm/get_fcm_token.dart';
import 'package:crm/features/auth/domain/usecases/login_usecase.dart';
import 'package:crm/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool isVisible = true;
  bool remember = false;

  bool validate() {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (!remember) {
      return false;
    }

    return isValid;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passwordCtrl.dispose();
    locator<AuthBloc>().add(CheckAuthEvent());
    super.dispose();
  }

  bool isDisableBtn() {
    if ((_nameCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) || !remember) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BgColorWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
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
                      AppStrings.signIn,
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
                          AppStrings.email,
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
                        ),
                        SizedBox(height: 25),

                        Text(
                          AppStrings.password,
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
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return '';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      remember = !remember;
                                    });
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    child: remember
                                        ? Icon(
                                            Icons.done,
                                            color: AppColors.primary,
                                            size: 16,
                                          )
                                        : null,
                                  ),
                                ),

                                SizedBox(width: 12),
                                Text(
                                  AppStrings.remember,
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
                            // TextButton(
                            //   onPressed: () {
                            //     context.push(AppRoutes.changePassword);
                            //   },
                            //   child: Text(
                            //     AppStrings.forgetPassword,
                            //     textAlign: TextAlign.end,
                            //
                            //     style: TextStyle(
                            //       fontFamily: TextFonts.nunito,
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 14,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 35),

                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is Authenticated) {
                          toastification.show(
                            context: context,
                            title: Text(AppStrings.loggedSuccessfully),
                            autoCloseDuration: const Duration(seconds: 3),
                          );
                          context.go(AppRoutes.orderPage);
                        } else if (state is AuthFailure) {
                          toastification.show(
                            context: context,
                            title: Text(AppStrings.error),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                      },
                      builder: (context, state) {
                        return MainButton(
                          buttonTile: AppStrings.login,
                          onPressed: () async {
                            final fcmToken = await locator<GetFcmToken>()
                                .getFcmToken();
                            final name = _nameCtrl.text.trim();
                            final password = _passwordCtrl.text.trim();

                            if (validate()) {
                              final params = LoginParams(
                                password: password,
                                username: name,
                                fcmToken: fcmToken.toString(),
                              );
                              locator<AuthBloc>().add(LogInEvent(params));
                              log(params.toString(), name: 'ver params');
                            }
                          },
                          isDisable: isDisableBtn(),
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    // TextButton(
                    //   onPressed: () {
                    //     context.push(AppRoutes.signUp);
                    //   },
                    //
                    //   child: Text(
                    //     AppStrings.noAccount,
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontFamily: TextFonts.nunito,
                    //
                    //       fontWeight: FontWeight.w600,
                    //       color: AppColors.white,
                    //     ),
                    //   ),
                    // ),
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

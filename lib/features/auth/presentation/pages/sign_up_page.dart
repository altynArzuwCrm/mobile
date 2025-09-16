// import 'package:crm/common/widgets/k_textfield.dart';
// import 'package:crm/common/widgets/main_btn.dart';
// import 'package:crm/core/config/routes/routes_path.dart';
// import 'package:crm/core/constants/colors/app_colors.dart';
// import 'package:crm/core/constants/strings/app_strings.dart';
// import 'package:crm/core/constants/strings/text_fonts.dart';
// import 'package:crm/features/auth/presentation/widgets/bg_card_widget.dart';
// import 'package:crm/features/auth/presentation/widgets/bg_color_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   final formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameCtrl = TextEditingController();
//   final TextEditingController _surnameCtrl = TextEditingController();
//   final TextEditingController _positionCtrl = TextEditingController();
//   final TextEditingController _emailCtrl = TextEditingController();
//   final TextEditingController _passwordCtrl = TextEditingController();
//   bool remember = false;
//
//   bool isVisible = true;
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     _positionCtrl.dispose();
//     _surnameCtrl.dispose();
//     _nameCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BgColorWidget(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 60),
//             Text(
//               AppStrings.appName,
//
//               style: TextStyle(
//                 fontFamily: TextFonts.nunito,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 60),
//             BgCardWidget(
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       AppStrings.registration,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: TextFonts.nunito,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 22,
//                         color: Colors.white,
//                       ),
//                     ),
//
//                     SizedBox(height: 35),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           AppStrings.name,
//                           textAlign: TextAlign.start,
//
//                           style: TextStyle(
//                             fontFamily: TextFonts.nunito,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         KTextField(
//                           controller: _nameCtrl,
//                           isSubmitted: false,
//                           hintText: AppStrings.writeName,
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           borderColor: AppColors.white,
//                           hintStyle: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                         ),
//                         SizedBox(height: 25),
//
//                         Text(
//                           AppStrings.surname,
//                           textAlign: TextAlign.start,
//
//                           style: TextStyle(
//                             fontFamily: TextFonts.nunito,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         KTextField(
//                           controller: _surnameCtrl,
//                           isSubmitted: false,
//                           hintText: AppStrings.enterSurname,
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           borderColor: AppColors.white,
//                           hintStyle: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                         ),
//                         SizedBox(height: 25),
//
//                         Text(
//                           AppStrings.position,
//                           textAlign: TextAlign.start,
//
//                           style: TextStyle(
//                             fontFamily: TextFonts.nunito,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         KTextField(
//                           controller: _positionCtrl,
//                           isSubmitted: false,
//                           hintText: AppStrings.enterPosition,
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           borderColor: AppColors.white,
//                           hintStyle: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                         ),
//                         SizedBox(height: 25),
//
//                         Text(
//                           AppStrings.email,
//                           textAlign: TextAlign.start,
//
//                           style: TextStyle(
//                             fontFamily: TextFonts.nunito,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         KTextField(
//                           controller: _emailCtrl,
//                           isSubmitted: false,
//                           hintText: AppStrings.emailHint,
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           borderColor: AppColors.white,
//                           hintStyle: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                         ),
//                         SizedBox(height: 25),
//
//                         Text(
//                           AppStrings.password,
//                           textAlign: TextAlign.start,
//
//                           style: TextStyle(
//                             fontFamily: TextFonts.nunito,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         KTextField(
//                           controller: _passwordCtrl,
//                           isSubmitted: false,
//                           obscureText: isVisible,
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           borderColor: AppColors.white,
//                           hintStyle: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: TextFonts.nunito,
//                           ),
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isVisible = !isVisible;
//                               });
//                             },
//                             child: isVisible
//                                 ? const Icon(
//                                     Icons.visibility_outlined,
//                                     color: AppColors.white,
//                                   )
//                                 : const Icon(
//                                     Icons.visibility_off_outlined,
//                                     color: AppColors.white,
//                                   ),
//                           ),
//                           hintText: '••••••••',
//                         ),
//                         SizedBox(height: 17),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       remember = !remember;
//                                     });
//                                   },
//                                   child: Container(
//                                     height: 24,
//                                     width: 24,
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(4),
//                                       border: Border.all(
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                     child: remember
//                                         ? Icon(
//                                             Icons.done,
//                                             color: AppColors.primary,
//                                             size: 16,
//                                           )
//                                         : null,
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 12),
//                                 Text(
//                                   AppStrings.remember,
//                                   textAlign: TextAlign.start,
//
//                                   style: TextStyle(
//                                     fontFamily: TextFonts.nunito,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 context.push(AppRoutes.changePassword);
//                               },
//                               child: Text(
//                                 AppStrings.forgetPassword,
//                                 textAlign: TextAlign.end,
//
//                                 style: TextStyle(
//                                   fontFamily: TextFonts.nunito,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 35),
//                     MainButton(
//                       buttonTile: AppStrings.send,
//                       onPressed: () {
//                         context.go(AppRoutes.orderPage);
//                       },
//                       isLoading: false,
//                       hasIcon: true,
//                     ),
//                     SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//
//                       child: Text(
//                         AppStrings.hasAccount,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: TextFonts.nunito,
//
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

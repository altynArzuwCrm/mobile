import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/users/domain/entities/user_entity.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/features/users/presentation/cubits/user_details/user_details_cubit.dart';
import 'package:crm/features/users/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, required this.user});

  final UserEntity user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final userDetailsCubit = locator<UserDetailsCubit>();
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _surnameCtrl;

  late final TextEditingController _positionCtrl;

  late final TextEditingController _emailCtrl;

  late final TextEditingController _numberCtrl;

  late final TextEditingController _locationCtrl;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.user.name);
    _surnameCtrl = TextEditingController(text: widget.user.username);
    _positionCtrl = TextEditingController(
      text: widget.user.roles?.first.displayName,
    );
    _emailCtrl = TextEditingController(text: '');
    _numberCtrl = TextEditingController(text: widget.user.phone);
    _locationCtrl = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _positionCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _numberCtrl.dispose();

    super.dispose();
  }

  clear() {
    _nameCtrl.clear();
    _surnameCtrl.clear();
    _positionCtrl.clear();
    _emailCtrl.clear();
    _locationCtrl.clear();
    _numberCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainCardWidget(
            child: Form(
              key: formKey,
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
                  CustomTextFieldWithTitle(
                    controller: _nameCtrl,

                    title: AppStrings.name,
                    hintText: widget.user.name,
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _surnameCtrl,
                    title: AppStrings.surname,
                    hintText: widget.user.username,
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _positionCtrl,
                    title: AppStrings.position,
                    hintText: widget.user.roles?.first.displayName ?? '',
                  ),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          AppStrings.company,
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
                        hintText: 'Cadabra',
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
                  CustomTextFieldWithTitle(
                    controller: _surnameCtrl,
                    title: AppStrings.location,
                    hintText: 'NYC, New York, USA',
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.gray,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          AppStrings.birthday,
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
                  Text(
                    AppStrings.contacts,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomTextFieldWithTitle(
                    controller: _emailCtrl,
                    title: AppStrings.email,
                    hintText: 'evanyates@gmail.com',
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWithTitle(
                    controller: _numberCtrl,
                    title: AppStrings.number,
                    hintText: widget.user.phone,
                  ),
                  SizedBox(height: 35),
                  BlocProvider.value(
                    value: userDetailsCubit,
                    child: BlocConsumer<UserDetailsCubit, UserDetailsState>(
                      listener: (context, state) {
                        if (state is UserDetailsLoaded) {
                          toastification.show(
                            context: context,
                            title: Text('успешно'),
                            autoCloseDuration: const Duration(seconds: 3),
                          );

                          locator<UserListCubit>().getAllUsers(UserParams());

                          context.pop();
                          clear();
                        } else if (state is UserDetailsError) {
                          toastification.show(
                            context: context,
                            title: Text(AppStrings.error),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        } else if (state is UserDetailsConnectionError) {
                          toastification.show(
                            context: context,
                            title: Text(AppStrings.noInternet),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                      },
                      builder: (context, state) {
                        return MainButton(
                          buttonTile: AppStrings.save,
                          onPressed: () {
                            bool isValid =
                                formKey.currentState?.validate() ?? false;

                            if (isValid) {
                              userDetailsCubit.editUser(
                                CreateUserParams(
                                  id: widget.user.id,
                                  name: _nameCtrl.text,
                                  username: _surnameCtrl.text,
                                  phone: _numberCtrl.text,
                                ),
                              );
                            }
                          },
                          isLoading: state is UserDetailsLoading,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

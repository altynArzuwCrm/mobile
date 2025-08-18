import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({super.key});

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String? selectedClientId;
  final clientsCubit = locator<ClientsCubit>();
  final projectsBloc = locator<ProjectsBloc>();
  final productsCubit = locator<ProductsCubit>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _countCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientsCubit.getAllClients(UserParams());
    projectsBloc.add(GetAllProjects(ProjectParams()));
    productsCubit.getAllProducts(ProductParams());
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _nameCtrl.dispose();
    _countCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: BottomSheetTitle(title: AppStrings.addOrder),
          ),
          Divider(color: AppColors.divider, thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    TextFieldTitle(
                      title: AppStrings.orderTitle,
                      child: KTextField(
                        controller: _nameCtrl,
                        isSubmitted: false,
                        hintText: '',
                        hintStyle: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14,
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

                    SizedBox(height: 20),

                    TextFieldTitle(
                      title: AppStrings.customer,
                      child: BlocProvider.value(
                        value: clientsCubit,
                        child: BlocBuilder<ClientsCubit, ClientsState>(
                          builder: (context, state) {
                            final inputDecoration = InputDecoration(
                              hintText: state is ClientsLoading
                                  ? "Loading clients..."
                                  : state is ClientsError
                                  ? "Failed to load"
                                  : "Select client",
                              filled: true,
                              fillColor: AppColors.white,
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.gray,
                                size: 30,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  // highlight color when focused
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  // highlight color when focused
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  width: 1,
                                ),
                              ),
                            );

                            if (state is ClientsLoaded) {
                              return EasyAutocomplete(
                                suggestions: state.data
                                    .map((c) => c.name)
                                    .toList(),
                                initialValue: '',
                                onChanged: (value) {
                                  final matches = state.data
                                      .where((c) => c.name == value)
                                      .toList();
                                  if (matches.isNotEmpty) {
                                    final client = matches.first;
                                    //  clientsCubit.selectClient(client.id.toString());
                                    selectedClientId = client.id.toString();
                                  } else {
                                    selectedClientId = null;
                                  }
                                },
                                validator: (_) {
                                  if (selectedClientId == null) {
                                    return 'Выберите клиента';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration,
                              );
                            } else {
                              return IgnorePointer(
                                ignoring: true,
                                child: EasyAutocomplete(
                                  suggestions: const <String>[],
                                  initialValue: '',
                                  onChanged: (_) {},
                                  decoration: inputDecoration,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    //2
                    SizedBox(height: 20),
                    TextFieldTitle(
                      title: AppStrings.project,
                      child: BlocBuilder<ProjectsBloc, ProjectsState>(
                        builder: (context, state) {
                          final inputDecoration = InputDecoration(
                            hintText: state is ProjectsLoading
                                ? "Loading projects..."
                                : state is ClientsError
                                ? "Failed to load"
                                : "Select project",
                            filled: true,
                            fillColor: AppColors.white,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.gray,
                              size: 30,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: AppColors.timeBorder,
                                // highlight color when focused
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: AppColors.timeBorder,
                                // highlight color when focused
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: AppColors.timeBorder,
                                width: 1,
                              ),
                            ),
                          );

                          if (state is ProjectsLoaded) {
                            return EasyAutocomplete(
                              suggestions: state.data
                                  .map((c) => c.title)
                                  .toList(),
                              initialValue: '',
                              onChanged: (value) {
                                final matches = state.data
                                    .where((c) => c.title == value)
                                    .toList();
                                if (matches.isNotEmpty) {
                                  final client = matches.first;
                                  //  clientsCubit.selectClient(client.id.toString());
                                  selectedClientId = client.id.toString();
                                } else {
                                  selectedClientId = null;
                                }
                              },
                              validator: (_) {
                                if (selectedClientId == null) {
                                  return 'Выберите проект';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            );
                          } else {
                            return IgnorePointer(
                              ignoring: true,
                              child: EasyAutocomplete(
                                suggestions: const <String>[],
                                initialValue: '',
                                onChanged: (_) {},
                                decoration: inputDecoration,
                              ),
                            );
                          }
                        },
                      ),
                    ),

                    //3

                    SizedBox(height: 20),
                    TextFieldTitle(
                      title: AppStrings.product,
                      child: BlocProvider.value(
                        value: productsCubit,
                        child: BlocBuilder<ProductsCubit, ProductsState>(
                          builder: (context, state) {
                            final inputDecoration = InputDecoration(
                              hintText: state is ProductsLoading
                                  ? "Loading projects..."
                                  : state is ClientsError
                                  ? "Failed to load"
                                  : "Select product",
                              filled: true,
                              fillColor: AppColors.white,
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.gray,
                                size: 30,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  // highlight color when focused
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  // highlight color when focused
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.timeBorder,
                                  width: 1,
                                ),
                              ),
                            );

                            if (state is ProductsLoaded) {
                              return EasyAutocomplete(
                                suggestions: state.data
                                    .map((c) => c.name)
                                    .toList(),
                                initialValue: '',
                                onChanged: (value) {
                                  final matches = state.data
                                      .where((c) => c.name == value)
                                      .toList();
                                  if (matches.isNotEmpty) {
                                    final client = matches.first;
                                    //  clientsCubit.selectClient(client.id.toString());
                                    selectedClientId = client.id.toString();
                                  } else {
                                    selectedClientId = null;
                                  }
                                },
                                validator: (_) {
                                  if (selectedClientId == null) {
                                    return 'Выберите проект';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration,
                              );
                            } else {
                              return IgnorePointer(
                                ignoring: true,
                                child: EasyAutocomplete(
                                  suggestions: const <String>[],
                                  initialValue: '',
                                  onChanged: (_) {},
                                  decoration: inputDecoration,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFieldTitle(
                      title: AppStrings.count,
                      child: KTextField(
                        controller: _countCtrl,
                        isSubmitted: false,
                        hintText: '',
                        hintStyle: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14,
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

                    //4
                    SizedBox(height: 20),

                    TextFieldTitle(
                      title: AppStrings.sum,
                      child: KTextField(
                        controller: _priceCtrl,
                        isSubmitted: false,
                        hintText: '2500тмт',
                        hintStyle: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14,
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

                    //6
                    SizedBox(height: 30),

                    TextFieldTitle(
                      title: AppStrings.dedline,
                      child: SelectDateWidget(
                        includeTime: true,
                        dateFormat: 'dd MMMM yyyy, HH:mm',
                        //  locale: const Locale('ru'),
                        onDateSelected: (date) {
                          debugPrint('Selected: $date');
                        },
                      ),
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
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Divider(color: AppColors.divider, thickness: 1),
                    SizedBox(height: 25),


                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MainButton(
              buttonTile: AppStrings.create,
              onPressed: () {},
              isLoading: false,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

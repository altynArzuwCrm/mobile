import 'dart:developer';
import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/assignments/data/models/assign_order_params.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/pages/components/add_client_widget.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/pages/components/new_order_item.dart';
import 'package:crm/features/orders/presentation/pages/components/single_order_item.dart';
import 'package:crm/features/orders/presentation/widgets/add_product_btn.dart';
import 'package:crm/features/orders/presentation/widgets/selectable_card.dart';
import 'package:crm/features/orders/presentation/widgets/widget_model/order_item_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/projects/presentations/pages/add_project_page.dart';
import 'package:crm/features/stages/presentation/cubits/stage_with_users/stage_with_users_cubit.dart';
import 'package:crm/features/stages/presentation/pages/stage_with_users_page.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/clients_selector.dart';
import 'components/project_selector.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final clientsCubit = locator<ClientsCubit>();
  final projectsBloc = locator<ProjectsBloc>();
  final productsCubit = locator<ProductsCubit>();
  final stageWithUsersCubit = locator<StageWithUsersCubit>();
  final ordersCubit = locator<OrdersCubit>();

  int selectedIndex = 0;
  bool newClient = false;
  bool newProject = false;

  String? selectedClientId;
  String? selectedProjectId;
  String? selectedProductId;
  DateTime? deadline;

  final TextEditingController _newClientNameCtrl = TextEditingController();
  final TextEditingController _newClientPhoneCtrl = TextEditingController();
  final TextEditingController _newProjectNameCtrl = TextEditingController();

  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _countCtrl = TextEditingController();
  // final TextEditingController _productCtrl = TextEditingController();
  List<OrderItemModel> orderItems = [];
  final List<AssignOrderParams>? assignments = [];

  clearData() {
    if (selectedIndex == 0) {
      selectedProductId = null;
      deadline = null;
      _priceCtrl.clear();
      _countCtrl.clear();
      // _productCtrl.clear();
      _newClientPhoneCtrl.clear();
    }
    if (selectedIndex == 1) {
      orderItems.clear();
    }
    log(
      'selectedClientId - $selectedClientId \n selectedProjectId - $selectedProjectId\n selectedProductId - $selectedProductId',
    );
  }

  @override
  void initState() {
    super.initState();
    clientsCubit.getAllClients(UserParams());
    projectsBloc.add(GetAllProjects(ProjectParams()));
    productsCubit.getAllProducts(ProductParams());
    if (selectedIndex == 0) {
      orderItems = [OrderItemModel(selectedProductId: selectedProductId)];
    }

    stageWithUsersCubit.getStagesWithUsers();
  }

  @override
  void dispose() {
    _newClientNameCtrl.dispose();
    _newProjectNameCtrl.dispose();
    _priceCtrl.dispose();
    _countCtrl.dispose();
    _newClientPhoneCtrl.dispose();

    for (var c in orderItems) {
      c.countCtrl.dispose();
      c.productCtrl.dispose();
      c.priceCtrl.dispose();
    }

    super.dispose();
  }



  void addToAssignment(int stageId, int userId, String role) {
    // Remove any existing selection for this stage
    assignments?.removeWhere((p) => p.stageId == stageId);

    // Add new selection
    assignments?.add(AssignOrderParams(
      userId: userId,
      role: role,
      stageId: stageId,
    ));

    print("Updated products: ${assignments?.map((e) => e.toQueryParameters()).toList()}");
  }

  void addNewClient() {
    setState(() {
      newClient = true;
      selectedClientId = null;
    });
  }

  void deleteNewClient() {
    setState(() {
      newClient = false;
      _newClientNameCtrl.clear();
    });
  }

  void addNewProject() {
    setState(() {
      newProject = true;
      selectedProjectId = null;
    });
  }

  void deleteNewProject() {
    setState(() {
      newProject = false;

      _newProjectNameCtrl.clear();
    });
  }

  void _openAddClient() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddClientWidget();
      },
    );
  }

  void _openAddProject() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddProjectWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.addOrder)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Тип заказа'),

                      SizedBox(height: 15),
                      SelectableCardRow(
                        options: ["Одиночный", "Массовый"],
                        onChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                          clearData();
                          print("Selected option index: $index");
                        },
                      ),

                      ///1 client
                      SizedBox(height: 15),
                      TextFieldTitle(
                        title: AppStrings.customer,
                        child: Row(
                          children: [
                            Expanded(
                              child: BlocProvider.value(
                                value: clientsCubit,
                                child: ClientsSelector(
                                  onSelectClient: (value) {
                                    selectedClientId = value;
                                    print('selectedClientId $selectedClientId');
                                  },
                                  newClient: newClient,
                                ),
                                // BlocBuilder<ClientsCubit, ClientsState>(
                                //   builder: (context, state) {
                                //     final inputDecoration = InputDecoration(
                                //       hintText: state is ClientsLoading
                                //           ? "Loading clients..."
                                //           : state is ClientsError
                                //           ? "Failed to load"
                                //           : "Select client",
                                //       // filled: true,
                                //       //  fillColor: AppColors.white,
                                //       suffixIcon: const Icon(
                                //         Icons.keyboard_arrow_down_outlined,
                                //         color: AppColors.gray,
                                //         size: 30,
                                //       ),
                                //       contentPadding:
                                //       const EdgeInsets.symmetric(
                                //         horizontal: 12,
                                //         vertical: 14,
                                //       ),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(14),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.timeBorder,
                                //           // highlight color when focused
                                //           width: 1,
                                //         ),
                                //       ),
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(14),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.timeBorder,
                                //           // highlight color when focused
                                //           width: 1,
                                //         ),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(14),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.timeBorder,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     );
                                //
                                //     if (newClient || state is! ClientsLoaded) {
                                //       return IgnorePointer(
                                //         ignoring: true,
                                //         child: EasyAutocomplete(
                                //           suggestions: const <String>[],
                                //           initialValue: '',
                                //           onChanged: (_) {},
                                //           decoration: inputDecoration,
                                //         ),
                                //       );
                                //     } else {
                                //       return EasyAutocomplete(
                                //         suggestions: state.data
                                //             .map((c) => c.name)
                                //             .toList(),
                                //         initialValue: '',
                                //         onChanged: (value) {
                                //           final matches = state.data
                                //               .where((c) => c.name == value)
                                //               .toList();
                                //           if (matches.isNotEmpty) {
                                //             final client = matches.first;
                                //             //  clientsCubit.selectClient(client.id.toString());
                                //             selectedClientId = client.id
                                //                 .toString();
                                //           } else {
                                //             selectedClientId = null;
                                //           }
                                //         },
                                //         validator: (_) {
                                //           if (selectedClientId == null) {
                                //             return 'Выберите клиента';
                                //           }
                                //           return null;
                                //         },
                                //         decoration: inputDecoration,
                                //       );
                                //     }
                                //   },
                                // ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.bgColor,
                              ),
                              child: IconButton(
                                onPressed: _openAddClient,
                                // newClient
                                //     ? deleteNewClient
                                //     : addNewClient,
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // if (newClient)
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(height: 15),
                      //       TextFieldTitle(
                      //         title: AppStrings.customer,
                      //         child: Row(
                      //           children: [
                      //             Expanded(
                      //               child: KTextField(
                      //                 controller: _newClientNameCtrl,
                      //                 isSubmitted: false,
                      //                 hintText: '',
                      //                 hintStyle: TextStyle(
                      //                   color: AppColors.gray,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w400,
                      //                 ),
                      //                 style: TextStyle(
                      //                   color: AppColors.black,
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w400,
                      //                 ),
                      //                 borderColor: AppColors.timeBorder,
                      //               ),
                      //             ),
                      //             Container(
                      //               alignment: Alignment.center,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(14),
                      //                 color: AppColors.bgColor,
                      //               ),
                      //               child: IconButton(
                      //                 onPressed: deleteNewClient,
                      //                 icon: Icon(Icons.remove_circle_outline),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(height: 15),
                      //       PhoneNumField(phoneCtrl: _newClientPhoneCtrl, isSubmitted: false),
                      //       SizedBox(height: 15),
                      //       Align(
                      //         alignment: Alignment.centerRight,
                      //         child: MainButton(buttonTile: 'Создать', onPressed: (){}, isLoading: false,
                      //         width: 150,
                      //
                      //         ),
                      //       ),
                      //
                      //     ],
                      //   ),

                      /// 2 project
                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.project,
                        child: Row(
                          children: [
                            Expanded(
                              child: ProjectSelector(
                                onSelectProject: (value) {
                                  selectedProjectId = value;
                                },
                                newProject: newProject,
                                selectedIndex: selectedIndex,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.bgColor,
                              ),
                              child: IconButton(
                                onPressed: _openAddProject,

                                // newProject
                                //     ? deleteNewProject
                                //     : addNewProject,
                                icon: Icon(Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (newProject)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            TextFieldTitle(
                              title: AppStrings.project,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: KTextField(
                                      controller: _newProjectNameCtrl,
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
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.bgColor,
                                    ),
                                    child: IconButton(
                                      onPressed: deleteNewProject,
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: MainButton(
                                buttonTile: 'Создать',
                                onPressed: () {},
                                isLoading: false,
                                width: 150,
                              ),
                            ),
                          ],
                        ),

                      selectedIndex == 0
                          ? SingleOrderItem(
                              priceCtrl: _priceCtrl,
                              countCtrl: _countCtrl,
                              onSelectDate: (v) {
                                deadline = v;
                              },
                              onSelectProduct: (p) {
                                selectedProductId = p;
                              },
                            )
                          : Column(
                              children: orderItems.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;

                                return NewOrderItem(
                                  item: item,
                                  onRemove: () {
                                    setState(() {
                                      orderItems.removeAt(index);
                                    });
                                  },
                                );
                              }).toList(),
                            ),

                      if (selectedIndex == 1)
                        AddProductBtn(
                          onTap: () {
                            setState(() {
                              orderItems.add(OrderItemModel());
                            });
                          },
                        ),
                      SizedBox(height: 20),

                      BlocProvider.value(
                        value: stageWithUsersCubit,
                        child:
                            BlocBuilder<
                              StageWithUsersCubit,
                              StageWithUsersState
                            >(
                              builder: (context, state) {
                                if (state is StageWithUsersLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is StageWithUsersError) {
                                  return Center(child: Text(state.message));
                                } else if (state is StageWithUsersLoaded) {
                                  final stageUsersMap = state.stageUsersMap;

                                  return Column(
                                    children: stageUsersMap.entries.map((
                                      entry,
                                    ) {
                                      final stage = entry.key;
                                      final users = entry.value;

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20.0,
                                        ),
                                        child: StageCategoryWidget(
                                          stage: stage,
                                          users: users,
                                          onSelectUser: (user) {
                                            print("Selected from ${stage.name}: id=${user?.id}");
                                            if (user != null) {
                                              print("Selected from ${stage.name}: id=${user.id}");
                                              addToAssignment(stage.id, user.id, stage.name);
                                            }
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MainButton(
                buttonTile: AppStrings.create,
                onPressed:_submit,
                //     () {
                //
                //   setState(() {});
                //   var a = OrderItemModel(
                //     initialCount: _countCtrl.text,
                //     initialPrice: _priceCtrl.text,
                //     deadline: deadline,
                //     selectedProductId: selectedProductId,
                //   );
                //
                //   // Now you can post this
                //   print(a);
                // },
                isLoading: false,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _submit(){
    // final orders = orderItems.map((c) {
    //   return OrderItemModel(
    //       initialProduct: c.productCtrl.text,
    //       initialCount: c.countCtrl.text,
    //       initialPrice: c.priceCtrl.text,
    //       deadline: c.deadline,
    //       selectedProductId: c.selectedProductId
    //   );
    // }).toList();


    final products = orderItems.map((c) {
      return MultipleProductParams(
          productName: c.productCtrl.text,
          quantity: int.parse(c.countCtrl.text),
          price: int.parse(c.priceCtrl.text),
          deadline: c.deadline,
      );
    }).toList();

    // print(orders);

    // final itemsData = orderItems.map((c) => c.toJson()).toList();
    //
    // // Build full payload
    // final payload = {
    //   'client_id': selectedClientId,
    //   'project_id': selectedProductId,
    //   'order_type': selectedIndex == 0 ? 'single' : 'multiple',
    //   'items': itemsData,
    // };

    final param =  CreateOrderParams(
      clientId: int.parse(selectedClientId??'0'),
      projectId: int.parse(selectedProjectId??'0'),
      productId:int.parse(selectedProductId??'0'),
      quantity: int.parse(_countCtrl.text??'0'),
      price:  int.parse(_priceCtrl.text??'0'),
      deadline: deadline,
      products: products,
      assignments:assignments,

    );
    print(param.toQueryParameters());

    // ordersCubit.createOrder(
    //    param);
  }

}


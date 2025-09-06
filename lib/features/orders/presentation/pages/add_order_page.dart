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
import 'package:crm/features/products/presentation/pages/add_product_page.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/projects/presentations/pages/add_project_page.dart';
import 'package:crm/features/stages/presentation/cubits/stage_with_users/stage_with_users_cubit.dart';
import 'package:crm/features/stages/presentation/pages/stage_with_users_page.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

  String? selectedClientId;
  String? selectedProjectId;
  String? selectedProductId;
  DateTime? deadline;

  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _countCtrl = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  List<OrderItemModel> orderItems = [];

  clearData() {
    if (selectedIndex == 0) {
      selectedProductId = null;
      deadline = null;
      _priceCtrl.clear();
      _countCtrl.clear();
    }
    if (selectedIndex == 1) {
      orderItems.clear();
    }
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
    _priceCtrl.dispose();
    _countCtrl.dispose();

    for (var c in orderItems) {
      c.countCtrl.dispose();
      c.productCtrl.dispose();
      c.priceCtrl.dispose();
    }

    super.dispose();
  }

  List<AssignOrderParams> assignments = [];

  void addToAssignment(int stageId, int userId, String role) {
    assignments.removeWhere((p) => p.stageId == stageId);

    assignments.add(
      AssignOrderParams(userId: userId, role: role, stageId: stageId),
    );
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

  void _openAddProduct() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AddProductPage();
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
                      Text(AppStrings.orderType),

                      SizedBox(height: 15),
                      SelectableCardRow(
                        options: [AppStrings.single, AppStrings.multiple],
                        onChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                          clearData();
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
                                  },
                                ),
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
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),

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
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                      selectedIndex == 0
                          ? SingleOrderItem(
                              formKey: formKey1,
                              priceCtrl: _priceCtrl,
                              countCtrl: _countCtrl,
                              onSelectDate: (v) {
                                deadline = v;
                              },
                              onSelectProduct: (p) {
                                selectedProductId = p;
                              },
                              onAddProduct: _openAddProduct,
                            )
                          : BlocProvider.value(
                              value: locator<ProductsCubit>(),
                              child: Column(
                                children: orderItems.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final item = entry.value;

                                  return NewOrderItem(
                                    item: item,
                                    formKey: item.formKey,
                                    onRemove: () {
                                      setState(() {
                                        orderItems.removeAt(index);
                                      });
                                    }, onAddProduct: _openAddProduct,
                                  );
                                }).toList(),
                              ),
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
                            BlocBuilder<StageWithUsersCubit, StageWithUsersState>(
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
                                            if (user != null) {
                                              addToAssignment(
                                                stage.id,
                                                user.id,
                                                stage.name,
                                              );
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
                onPressed: () {
                  if (validate()) {
                    _submit();
                  }
                },
                isLoading: false,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final products = orderItems.map((c) {
      return MultipleProductParams(
        productId: c.selectedProductId,
        quantity: int.tryParse(c.countCtrl.text),
        price: int.tryParse(c.priceCtrl.text),
        deadline: c.deadline,
      );
    }).toList();

    final clientId = int.tryParse(selectedClientId ?? '');
    final projectId = int.tryParse(selectedProjectId ?? '');
    final productId = int.tryParse(
      selectedProductId ?? products.first.productId ?? '',
    );
    final quantity = int.tryParse(_countCtrl.text);
    final price = int.tryParse(_priceCtrl.text);
    final stage = assignments.isNotEmpty ? assignments.first.role : null;

    final param = CreateOrderParams(
      clientId: clientId,
      projectId: projectId,
      stage: stage,
      productId: productId,
      quantity: quantity,
      price: price,
      deadline: deadline,
      products: products,
      assignments: assignments,
    );

    ordersCubit.createOrder(param);

    context.pop();
  }

  bool validate() {
    // --- Common validations ---
    if (selectedClientId == null || selectedClientId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, выберите клиента")),
      );
      return false;
    }

    if (selectedProjectId == null || selectedProjectId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, выберите проект")),
      );
      return false;
    }

    // --- Single order validations ---
    if (selectedIndex == 0) {
      final formValid = formKey1.currentState?.validate() ?? false;
      if (!formValid) return false;

      if (selectedProductId == null || selectedProductId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Пожалуйста, выберите продукт")),
        );
        return false;
      }

      if (deadline == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Пожалуйста, выберите срок сдачи")),
        );
        return false;
      }
    }

    // --- Multiple order validations ---
    if (selectedIndex == 1) {
      if (orderItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Добавьте хотя бы один продукт")),
        );
        return false;
      }

      for (final item in orderItems) {
        final formValid = item.formKey.currentState?.validate() ?? false;
        if (!formValid) return false;

        if (item.selectedProductId == null || item.selectedProductId!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Выберите продукт для всех позиций")),
          );
          return false;
        }

        if (item.deadline == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Укажите срок сдачи для всех позиций"),
            ),
          );
          return false;
        }
      }
    }

    // --- Assignments validation ---
    if (assignments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Назначьте хотя бы одного пользователя")),
      );
      return false;
    }

    return true;
  }
}

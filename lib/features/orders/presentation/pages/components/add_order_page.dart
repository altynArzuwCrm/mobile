import 'package:crm/common/widgets/k_textfield.dart';
import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/clients/presentation/pages/components/new_order_item.dart';
import 'package:crm/features/clients/presentation/pages/components/single_order_item.dart';
import 'package:crm/features/orders/presentation/widgets/add_product_btn.dart';
import 'package:crm/features/orders/presentation/widgets/selectable_card.dart';
import 'package:crm/features/orders/presentation/widgets/widget_model/order_item_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:crm/features/projects/presentations/blocs/projects_bloc/projects_bloc.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  String? selectedClientId;
  String? selectedProductId;
  DateTime? deadline;
  final clientsCubit = locator<ClientsCubit>();
  final projectsBloc = locator<ProjectsBloc>();
  final productsCubit = locator<ProductsCubit>();

  final TextEditingController _newClientNameCtrl = TextEditingController();
  final TextEditingController _newProjectNameCtrl = TextEditingController();

  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _countCtrl = TextEditingController();
  final TextEditingController _productCtrl = TextEditingController();
  int selectedIndex = 0;
  bool newClient = false;
  bool newProject = false;

  @override
  void initState() {
    super.initState();
    clientsCubit.getAllClients(UserParams());
    projectsBloc.add(GetAllProjects(ProjectParams()));
    productsCubit.getAllProducts(ProductParams());
    if (selectedIndex == 0) {
      orderItems = [OrderItemModel(selectedProductId: selectedProductId)];
    }
  }

  @override
  void dispose() {
    _newClientNameCtrl.dispose();
    _newProjectNameCtrl.dispose();
    _priceCtrl.dispose();
    _countCtrl.dispose();
    _productCtrl.dispose();

    for (var c in orderItems) {
      c.countCtrl.dispose();
      c.productCtrl.dispose();
      c.priceCtrl.dispose();
    }

    super.dispose();
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
    });
  }

  void deleteNewProject() {
    setState(() {
      newProject = false;

      _newProjectNameCtrl.clear();
    });
  }

  List<OrderItemModel> orderItems = [];

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
                                child: BlocBuilder<ClientsCubit, ClientsState>(
                                  builder: (context, state) {
                                    final inputDecoration = InputDecoration(
                                      hintText: state is ClientsLoading
                                          ? "Loading clients..."
                                          : state is ClientsError
                                          ? "Failed to load"
                                          : "Select client",
                                      // filled: true,
                                      //  fillColor: AppColors.white,
                                      suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: AppColors.gray,
                                        size: 30,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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

                                    if (newClient || state is! ClientsLoaded) {
                                      return IgnorePointer(
                                        ignoring: true,
                                        child: EasyAutocomplete(
                                          suggestions: const <String>[],
                                          initialValue: '',
                                          onChanged: (_) {},
                                          decoration: inputDecoration,
                                        ),
                                      );
                                    } else {
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
                                            selectedClientId = client.id
                                                .toString();
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
                                    }
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
                                onPressed: newClient
                                    ? deleteNewClient
                                    : addNewClient,
                                icon: Icon(
                                  newClient
                                      ? Icons.remove_circle_outline
                                      : Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (newClient)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            TextFieldTitle(
                              title: AppStrings.customer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: KTextField(
                                      controller: _newClientNameCtrl,
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
                                      onPressed: deleteNewClient,
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      /// 2 project
                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.project,
                        child: Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<ProjectsBloc, ProjectsState>(
                                builder: (context, state) {
                                  final inputDecoration = InputDecoration(
                                    hintText: state is ProjectsLoading
                                        ? "Loading projects..."
                                        : state is ClientsError
                                        ? "Failed to load"
                                        : "Select project",
                                    //  filled: true,
                                    //    fillColor: AppColors.white,
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
                                  if (newProject || state is! ProjectsLoaded) {
                                    return IgnorePointer(
                                      ignoring: true,
                                      child: EasyAutocomplete(
                                        suggestions: const <String>[],
                                        initialValue: '',
                                        onChanged: (_) {},
                                        decoration: inputDecoration,
                                      ),
                                    );
                                  } else {
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
                                          selectedProductId = client.id
                                              .toString();
                                        } else {
                                          selectedProductId = null;
                                        }
                                      },
                                      validator: (_) {
                                        if (selectedIndex == 1 &&
                                            selectedProductId == null) {
                                          return 'Выберите проект';
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration,
                                    );
                                  }
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.bgColor,
                              ),
                              child: IconButton(
                                onPressed: newProject
                                    ? deleteNewProject
                                    : addNewProject,
                                icon: Icon(
                                  newProject
                                      ? Icons.remove_circle_outline
                                      : Icons.add,
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
                          ],
                        ),

                      selectedIndex == 0
                          ? SingleOrderItem(
                              priceCtrl: _priceCtrl,
                              countCtrl: _countCtrl,
                              productCtrl: _productCtrl,
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
                  // final orders = orderItems.map((c) {
                  //   return OrderItemModel(initialProduct: c.productCtrl.text,
                  //       initialCount: c.countCtrl.text,
                  //       initialPrice: c.priceCtrl.text,
                  //       deadline: c.deadline,
                  //       selectedProductId: c.selectedProductId
                  //   );
                  // }).toList();
                  //
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
                  setState(() {});
                  var a = OrderItemModel(
                    initialCount: _countCtrl.text,
                    initialPrice: _priceCtrl.text,
                    deadline: deadline,
                    selectedProductId: selectedProductId,
                  );

                  // Now you can post this
                  print(a);
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
}

/**
 * {
    "client_id": "123",
    "project_id": "456",
    "is_mass_order": true,
    "new_client_name": null,
    "new_project_name": null,
    "items": [
    {
    "product_id": "вариант",
    "count": 1000,
    "price": 2000,
    "deadline": "2025-08-19T17:50:00.000"
    },
    {
    "product_id": "маша",
    "count": 6000,
    "price": 7000,
    "deadline": "2025-08-20T17:52:00.000"
    }
    ]
    }

 * */


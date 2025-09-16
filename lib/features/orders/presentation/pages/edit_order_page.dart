import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/textfield_title.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/order_details/order_detail_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/presentation/cubits/products/products_cubit.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'components/clients_selector.dart';
import 'components/product_selector.dart';

class EditOrderPage extends StatefulWidget {
  const EditOrderPage({super.key, required this.order});

  final OrderModel order;

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  final orderDetailsCubit = locator<OrderDetailCubit>();
  final stagesCubit = locator<StageCubit>();
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _titleCtrl;

  late final TextEditingController _quantityCtrl;
  late final TextEditingController _priceCtrl;

  late String? selectedStage;
  late String? clientId;
  late String? productId;
  final clientsCubit = locator<ClientsCubit>();
  final productsCubit = locator<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    stagesCubit.getAllStages();

    _titleCtrl = TextEditingController(text: widget.order.project?.title ?? '');

    _quantityCtrl = TextEditingController(
      text: widget.order.quantity.toString(),
    );
    _priceCtrl = TextEditingController(
      text: widget.order.price ?? 0.toString(),
    );

    selectedStage = widget.order.stage?.name;
    clientId = widget.order.clientId.toString();
    productId = widget.order.productId.toString();

    clientsCubit.getAllClients(UserParams());
    productsCubit.getAllProducts(ProductParams());
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _quantityCtrl.dispose();
    _priceCtrl.dispose();

    super.dispose();
  }

  clear() {
    _titleCtrl.clear();
    _quantityCtrl.clear();
    _priceCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editing)),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                        controller: _titleCtrl,

                        title: AppStrings.projectTitle,
                        hintText: widget.order.project?.title ?? '',
                      ),
                      SizedBox(height: 20),
                      TextFieldTitle(
                        title: AppStrings.customer,
                        child: BlocProvider.value(
                          value: clientsCubit,
                          child: ClientsSelector(
                            initialValue: widget.order.client?.name,
                            onSelectClient: (value) {
                              clientId = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      TextFieldTitle(
                        title: AppStrings.product,
                        child: BlocProvider.value(
                          value: locator<ProductsCubit>(),
                          child: ProductSelector(
                            initialValue: widget.order.product?.name,
                            onSelectProduct: (value) {
                              productId = value;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text(
                        AppStrings.stages,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                      SizedBox(height: 7),
                      BlocBuilder<StageCubit, StageState>(
                        builder: (context, state) {
                          if (state is StageLoading) {
                            return const SizedBox.shrink();
                          } else if (state is StageError) {
                            return Center(child: Text(AppStrings.error,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,));
                          } else if (state is StageLoaded) {
                            return CustomDropdownField(
                              value: state.selectedCategory,
                              onChanged: (val) {
                                stagesCubit.selectCategory(val);
                                selectedStage = val;
                              },
                              backgroundColor: AppColors.bgColor,
                              padding: EdgeInsets.zero,
                              hintText: widget.order.stage?.displayName,
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.gray,
                                size: 30,
                              ),
                              items: state.data
                                  .map(
                                    (stage) => DropdownMenuItem(
                                      value: stage.name,
                                      child: Text(stage.displayName,style: Theme.of(context).textTheme.titleSmall,),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      SizedBox(height: 20),

                      CustomTextFieldWithTitle(
                        controller: _quantityCtrl,
                        title: AppStrings.count,
                        hintText: '',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      CustomTextFieldWithTitle(
                        controller: _priceCtrl,
                        title: AppStrings.sum,
                        hintText: '',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            BlocProvider.value(
              value: orderDetailsCubit,
              child: BlocConsumer<OrderDetailCubit, OrderDetailState>(
                listener: (context, state) {
                  if (state is OrderDetailLoaded) {
                    toastification.show(
                      context: context,
                      title: Text(AppStrings.success),
                      autoCloseDuration: const Duration(seconds: 3),
                    );

                    locator<OrdersCubit>().getAllOrders(OrderParams());

                    context.pop();
                    clear();
                  } else if (state is OrderDetailError) {
                    toastification.show(
                      context: context,
                      title: Text(AppStrings.error),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  } else if (state is OrderDetailConnectionError) {
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
                      bool isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {

                        final params = CreateOrderParams(
                          id: widget.order.id,
                          title: _titleCtrl.text.trim(),
                          stage: selectedStage,
                          clientId: clientId,
                          productId: productId,
                          quantity: int.tryParse(_quantityCtrl.text.trim()),
                          price: int.tryParse(_priceCtrl.text.trim()),
                        );

                        orderDetailsCubit.updateOrder(params);
                      }
                    },
                    isLoading: state is OrderDetailLoading,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

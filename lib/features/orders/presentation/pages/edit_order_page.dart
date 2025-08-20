import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/presentation/cubits/order_details/order_detail_cubit.dart';
import 'package:crm/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:crm/features/orders/presentation/widgets/dropdown_widget.dart';
import 'package:crm/features/settings/presentation/widgets/custom_text_field.dart';
import 'package:crm/features/stages/presentation/cubits/all_stages/stage_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

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

  late final TextEditingController _descriptionCtrl;

  late String? selectedStage;

  @override
  void initState() {
    super.initState();
    stagesCubit.getAllStages();

    _titleCtrl = TextEditingController(text: widget.order.project?.title ?? '');

    _descriptionCtrl = TextEditingController();

    selectedStage = widget.order.stage?.name;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();

    super.dispose();
  }

  clear() {
    _titleCtrl.clear();
    _descriptionCtrl.clear();
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

                        title: 'Название проекта',
                        hintText: widget.order.project?.title ?? '',
                      ),

                      SizedBox(height: 20),

                      CustomTextFieldWithTitle(
                        controller: _descriptionCtrl,
                        title: AppStrings.description,
                        hintText: '',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Этапы',
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
                            return const Text(AppStrings.error);
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
                                      child: Text(stage.displayName),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
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
                      title: Text('успешно'),
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
                        orderDetailsCubit.updateOrder(
                          CreateOrderParams(
                            id: widget.order.id,
                            title: _titleCtrl.text.trim(),
                            description: _descriptionCtrl.text.trim(),
                            stage: selectedStage,
                            clientId: widget.order.clientId,
                            productId: widget.order.productId,
                            quantity: widget.order.quantity,
                          ),
                        );
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

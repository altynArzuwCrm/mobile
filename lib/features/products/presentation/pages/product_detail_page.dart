import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/products/presentation/cubits/product_detail/product_detail_cubit.dart';
import 'package:crm/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;

  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final productDetailCubit = locator<ProductDetailCubit>();

  @override
  void initState() {
    super.initState();
    productDetailCubit.getProductDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Подробности о продукте')),
      body: BlocProvider.value(
        value: productDetailCubit,
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailLoaded) {
              final data = state.data;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// --- PRODUCT INFO ---
                    Card(
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      // elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  data.isActive
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: data.isActive
                                      ? Colors.green
                                      : Colors.red,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data.isActive ? 'Активен' : 'Неактивен',

                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppColors.gray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Назначенные пользователи',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Assignments list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = data.assignments[index];
                        final user = assignment.user;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(child: Text(user.name[0])),
                            title: Text(user.name, style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.darkBlue
                            ),),
                          subtitle: Text(
                            assignment.roleType ?? 'Без роли', style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.darkBlue
                          ),),
                          trailing: assignment.isActive
                              ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                              : const Icon(Icons.cancel, color: Colors.red),
                        ),);
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Этапы процесса',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Stages chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: data.availableStages.map((stage) {
                        return Chip(
                          label: Text(stage.displayName),
                          backgroundColor: AppColors.primary,
                          labelStyle:  TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }

            return Center(child: Text(AppStrings.error));
          },
        ),
      ),
    );
  }
}

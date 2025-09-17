import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/category_btn.dart';
import 'package:flutter/material.dart';

class SortOrderSelector extends StatelessWidget {
  final String sortOrder; // "asc" or "desc"
  final ValueChanged<String> onChanged;
  final bool isIconOnly;

  const SortOrderSelector({
    super.key,
    required this.sortOrder,
    required this.onChanged,
    this.isIconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return isIconOnly
        ? PopupMenuButton<String>(
            initialValue: sortOrder,
            onSelected: onChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "asc",
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward, color: Colors.green),
                    SizedBox(width: 8),
                    Text("По возрастанию"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "desc",
                child: Row(
                  children: [
                    Icon(Icons.arrow_downward, color: Colors.red),
                    SizedBox(width: 8),
                    Text("По убыванию"),
                  ],
                ),
              ),
            ],
            child: const Icon(Icons.sort),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Сортировать',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CategoryBtn(
                      title: "По возрастанию",
                      isSelected: sortOrder == 'asc',
                      onTap: () {
                        onChanged('asc');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: CategoryBtn(
                      title: "По убыванию",
                      isSelected: sortOrder == 'desc',
                      onTap: () {
                        onChanged('desc');
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

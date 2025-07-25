import 'package:crm/common/widgets/main_btn.dart';
import 'package:crm/common/widgets/shimmer_image.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/features/orders/presentation/widgets/bottom_sheet_title.dart';
import 'package:crm/features/orders/presentation/widgets/dialog_widget.dart';
import 'package:crm/features/orders/presentation/widgets/search_chip.dart';
import 'package:crm/features/orders/presentation/widgets/search_widget.dart';
import 'package:crm/features/orders/presentation/widgets/select_date_widget.dart';
import 'package:crm/features/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  final TextEditingController _searchCtrl = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleCount = _isExpanded ? 10 : 5;

    return DialogWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: BottomSheetTitle(title: 'Фильтр'),
            ),
            Divider(color: AppColors.divider, thickness: 1),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Дедлайн',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.gray,
                ),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SelectDateWidget(
                includeTime: true,
                dateFormat: 'dd MMMM yyyy, HH:mm',
                //  locale: const Locale('ru'),
                onDateSelected: (date) {
                  print('Selected: $date');
                },
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Ответственный',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: visibleCount,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              checkboxTheme: CheckboxThemeData(
                                side: BorderSide(color: AppColors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                fillColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                            ),
                            child: Checkbox(
                              value: true,
                              onChanged: (value) {},
                              checkColor: AppColors.primary,
                            ),
                          ),
                          // SizedBox(width: 17),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ImageWithShimmer(
                              height: 24,
                              width: 24,
                              imageUrl: img,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Oscar Holloway',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                TextButton(
                  onPressed: _toggleExpanded,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'Меньше' : 'Больше',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
            SizedBox(height: 25),

            ///client
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Клиент',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 7),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HomePageSearchWidget(
                    searchCtrl: _searchCtrl,
                    onSearch: () {
                      setState(() {});
                    },
                    onClear: () {
                      setState(() {});
                      _searchCtrl.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: List.generate(
                      3,
                          (e) => SearchChip(
                        title: 'Violet R',
                        onTap: () {},
                        onDeleted: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
            SizedBox(height: 25),

            ///stadiya
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Стадия',
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
                  hintText: 'Оформление заказа',
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
            SizedBox(height: 45),

            ///Просрочено
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Просрочено',
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
                  hintText: 'Оформление заказа',
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

            SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, color: AppColors.primary),
                  SizedBox(width: 10),
                  Text(
                    'найдено 10 совпадений',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MainButton(
                buttonTile: 'Фильтр',
                onPressed: () {},
                isLoading: false,
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

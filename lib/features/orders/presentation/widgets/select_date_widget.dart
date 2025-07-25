import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final String dateFormat;
  final bool includeTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
//  final Locale? locale;

  const SelectDateWidget({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.dateFormat = 'dd.MM.yyyy',
    this.includeTime = false,
    this.firstDate,
    this.lastDate,
   // this.locale,
  });

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: widget.lastDate ?? DateTime(2100),
  //    locale: widget.locale,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor:AppColors.primary,),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    DateTime finalDate = pickedDate;

    if (widget.includeTime) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate ?? now),
      );
      if (pickedTime != null) {
        finalDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    setState(() => selectedDate = finalDate);
    widget.onDateSelected?.call(finalDate);
  }

  @override
  Widget build(BuildContext context) {
    final formatted = selectedDate != null
        ? DateFormat(widget.dateFormat, //widget.locale?.toString(),
    )
        .format(selectedDate!)
        : 'Выбрать период';

    return GestureDetector(
      onTap: _pickDateTime,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.timeBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatted,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: selectedDate != null ? AppColors.black : AppColors.gray,
              ),
            ),
            const Icon(Icons.calendar_today, size: 18, color:AppColors.gray,),
          ],
        ),
      ),
    );
  }
}

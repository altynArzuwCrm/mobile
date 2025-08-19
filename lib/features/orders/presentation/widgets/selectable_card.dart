import 'package:crm/common/widgets/main_card.dart';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class SelectableCardRow extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int>? onChanged;

  const SelectableCardRow({super.key, required this.options, this.onChanged});

  @override
  State<SelectableCardRow> createState() => _SelectableCardRowState();
}

class _SelectableCardRowState extends State<SelectableCardRow> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // smaller horizontal gap
      runSpacing: 8, // smaller vertical gap if wrapped
      children: [
        for (int i = 0; i < widget.options.length; i++)
          GestureDetector(
            onTap: () {
              setState(() => selectedIndex = i);
              widget.onChanged?.call(i);
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 120, maxWidth: 160),
              // smaller cards
              child: MainCardWidget(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ), // reduced padding
                color: selectedIndex == i
                    ? Colors.blue.shade50
                    : AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 0.8, // smaller checkbox
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        // tighter touch area
                        value: selectedIndex == i,
                        onChanged: (_) {
                          setState(() => selectedIndex = i);
                          widget.onChanged?.call(i);
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.options[i],
                        style: const TextStyle(
                          fontSize: 12, // smaller text
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

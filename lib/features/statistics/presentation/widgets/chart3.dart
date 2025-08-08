import 'package:flutter/material.dart';

class StatsBarChart extends StatelessWidget {
  const StatsBarChart({super.key});

  final List<Map<String, dynamic>> data = const [
    {"name": "Пользователь 1", "mainValue": 18, "subValue": 5, "mainPercent": 0.95, "subPercent": 0.35},
    {"name": "Пользователь 1", "mainValue": 18, "subValue": 5, "mainPercent": 0.92, "subPercent": 0.33},
    {"name": "Пользователь 1", "mainValue": 18, "subValue": 5, "mainPercent": 0.94, "subPercent": 0.38},
    {"name": "Пользователь 1", "mainValue": 18, "subValue": 5, "mainPercent": 0.91, "subPercent": 0.32},
    {"name": "Пользователь 1", "mainValue": 18, "subValue": 5, "mainPercent": 0.93, "subPercent": 0.36},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(data.length, (index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name
              SizedBox(
                width: 100,
                child: Text(
                  item["name"],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xff605D64)),
                  maxLines: 1,overflow: TextOverflow.ellipsis,

                ),
              ),
              const SizedBox(width: 5),

              // Values
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item["mainValue"].toString(),
                    style:  TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    item["subValue"].toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),

              // Bars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBar(item["mainPercent"], const [Color(0xFF6A85F1), Color(0xFF89C4F8)]),
                    _buildBar(item["subPercent"], [Color(0xffCBCBF6),Color(0xffCBCBF6),]),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBar(double percent, List<Color> colors) {
    return FractionallySizedBox(
      widthFactor: percent,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: colors),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:math' as math;
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final List<FlSpot> data;
  final double maxX;
  final double maxY;
  final List<String> bottomTitles;

  const LineChartSample2({
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.bottomTitles,
    super.key,
  });

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      AppColors.primary,
      const Color(0xff93AAFD),
      const Color(0xffC6D2FD),
      const Color.fromRGBO(229, 234, 252, 0.31),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 16, left: 0),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: LineChart(_buildChartData(gradientColors)),
      ),
    );
  }

  /// --- Formatting Helpers ---

  String formatNumber(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 1)}m';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}k';
    } else {
      return value.toInt().toString();
    }
  }

  double calculateNiceInterval(double maxY, {int steps = 4}) {
    if (maxY <= 0) return 1;
    double roughInterval = maxY / steps;
    final magnitude = math.pow(10, (math.log(roughInterval) / math.log(10)).floor());
    double normalized = roughInterval / magnitude;
    double niceNormalized;
    if (normalized <= 1) {
      niceNormalized = 1;
    } else if (normalized <= 2) {
      niceNormalized = 2;
    } else if (normalized <= 5) {
      niceNormalized = 5;
    } else {
      niceNormalized = 10;
    }
    return niceNormalized * magnitude;
  }

  /// --- Axis Widgets ---

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.chartTextColor,
      fontSize: 8,
      fontWeight: FontWeight.w400,
      fontFamily: TextFonts.inter,
    );

    final text = (value.toInt() >= 0 && value.toInt() < widget.bottomTitles.length)
        ? widget.bottomTitles[value.toInt()]
        : '';

    // Trim long text
    final trimmedText = text.length > 6 ? '${text.substring(0, 6)}…' : text;
    final angle = text.length > 4 ? -0.5 : 0.0; // rotate if longer than 4 chars

    return SideTitleWidget(
      meta: meta,
      angle: angle,
      space: 8.0,
      child: Text(trimmedText.toUpperCase(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.chartTextColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      fontFamily: TextFonts.inter,
    );

    return SideTitleWidget(
      meta: meta,
      child: Text(formatNumber(value), style: style),
    );
  }

  /// --- Chart Data ---

  LineChartData _buildChartData(List<Color> gradientColors) {
    final leftInterval = calculateNiceInterval(widget.maxY, steps: 4);

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                formatNumber(spot.y),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: AppColors.chartLineColor.withOpacity(0.5),
          strokeWidth: 1,
          dashArray: [5, 5],
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: AppColors.chartLineColor.withOpacity(0.5),
          strokeWidth: 1,
          dashArray: [5, 5],
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: leftInterval,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      minX: 0,
      maxX: widget.maxX,
      minY: 0,
      maxY: widget.maxY,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: false,
          color: AppColors.primary,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: Colors.white,
              strokeWidth: 2,
              strokeColor: AppColors.primary,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.3), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

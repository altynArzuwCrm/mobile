import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({
    super.key,
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.bottomTitles,
    required this.leftTitles,
  });

  final List<FlSpot> data;
  final double maxX;
  final double maxY;
  final List<String> bottomTitles;
  final List<dynamic> leftTitles;

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      AppColors.primary,

      Color(0xff93AAFD),
      Color(0xffC6D2FD),
      Color.fromRGBO(229, 234, 252, 0.31),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 16, left: 0),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: LineChart(_buildChartData(gradientColors)),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.chartTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: TextFonts.inter,
    );

    final text =
        (value.toInt() >= 0 && value.toInt() < widget.bottomTitles.length)
        ? widget.bottomTitles[value.toInt()]
        : '';
    final bottomText = text.length > 3 ? text.substring(0, 3) : text;

    return SideTitleWidget(
      meta: meta,
      angle: 0.0,
      space: 8.0,
      child: Text(bottomText.toUpperCase(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.chartTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: TextFonts.inter,
    );

    if (value.toInt() >= 0 && value.toInt() < widget.leftTitles.length) {
      return SideTitleWidget(
        meta: meta,
        angle: 0.0,
        space: 8.0,
        child: Text(
          widget.leftTitles[value.toInt()].toString(),
          style: style,
          textAlign: TextAlign.left,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  LineChartData _buildChartData(List<Color> gradientColors) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: Colors.black,
          // tooltipRoundedRadius: 8,
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toInt()}',
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
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.chartLineColor.withOpacity(0.5),
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.chartLineColor.withOpacity(0.5),
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
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
            reservedSize: 32,
            interval: 1,
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
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: AppColors.primary,
              );
            },
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

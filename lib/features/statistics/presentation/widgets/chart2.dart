import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2({super.key});

  final Color leftBarColor = AppColors.green;
  final Color rightBarColor = AppColors.blue;
  final Color avgColor = AppColors.lightBlue;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 15;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    // Data adjusted to match the image
    final barGroup1 = makeGroupData(0, 75, 40);
    final barGroup2 = makeGroupData(1, 75, 41);
    final barGroup3 = makeGroupData(2, 75, 41);
    final barGroup4 = makeGroupData(3, 75, 41);
    final barGroup5 = makeGroupData(4, 75, 41);
    final barGroup6 = makeGroupData(5, 75, 41);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: BarChart(
          BarChartData(
            maxY: 100,
            // Max Y value to match the image
            barTouchData: BarTouchData(enabled: false),
            // Disable touch interaction for simplicity
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  reservedSize: 42,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 20, // Adjusted interval to match the image
                  getTitlesWidget: leftTitles,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: showingBarGroups,
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 10,
      fontFamily: TextFonts.inter,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 20) {
      text = '20';
    } else if (value == 40) {
      text = '40';
    } else if (value == 60) {
      text = '60';
    } else if (value == 80) {
      text = '80';
    } else if (value == 100) {
      text = '100';
    } else {
      return Container();
    }
    return SideTitleWidget(
      space: 10,
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff838383),
        fontWeight: FontWeight.w500,
        fontSize: 10,
        fontFamily: TextFonts.inter,
      ),
    );

    return SideTitleWidget(space: 16, meta: meta, child: text);
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: width,
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(10, 201, 71, 1),
        ),
        BarChartRodData(
          toY: y2,
          width: width,
          color: Color.fromRGBO(0, 91, 255, 0.8),
          borderRadius: BorderRadius.circular(100),
        ),
      ],
    );
  }
}

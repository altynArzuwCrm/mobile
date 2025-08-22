
class StatisticsModel {
  final List<MonthlyData> monthlyData;
  final int totalRevenue;
  final String totalRevenueFormatted;
  final String year;

  StatisticsModel({
    required this.monthlyData,
    required this.totalRevenue,
    required this.totalRevenueFormatted,
    required this.year,
  });
  factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
    monthlyData: List<MonthlyData>.from(json["monthly_data"].map((x) => MonthlyData.fromJson(x))),
    totalRevenue: json["total_revenue"],
    totalRevenueFormatted: json["total_revenue_formatted"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "monthly_data": List<dynamic>.from(monthlyData.map((x) => x.toJson())),
    "total_revenue": totalRevenue,
    "total_revenue_formatted": totalRevenueFormatted,
    "year": year,
  };
}

class MonthlyData {
  final int month;
  final String monthName;
  final int revenue;
  final String revenueFormatted;

  MonthlyData({
    required this.month,
    required this.monthName,
    required this.revenue,
    required this.revenueFormatted,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) => MonthlyData(
    month: json["month"],
    monthName: json["month_name"],
    revenue: json["revenue"],
    revenueFormatted: json["revenue_formatted"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "month_name": monthName,
    "revenue": revenue,
    "revenue_formatted": revenueFormatted,
  };
}

class ActivityModel {
  final List<ActivityData> activities;
  final int total;

  ActivityModel({required this.activities, required this.total});

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    activities: List<ActivityData>.from(
      json["activities"].map((x) => ActivityData.fromJson(x)),
    ),
    total: json["total"],
  );
}

class ActivityData {
  final String id;
  final String type;
  final String title;
  final String description;
  final String user;
  final DateTime timestamp;
  final String? amount;

  ActivityData({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.user,
    required this.timestamp,
    required this.amount,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    description: json["description"],
    user: json["user"],
    timestamp: DateTime.parse(json["timestamp"]),
    amount: json["amount"],
  );
}

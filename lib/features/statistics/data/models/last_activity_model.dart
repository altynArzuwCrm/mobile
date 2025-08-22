class LastActivityModel {
  final String id;
  final String title;
  final DateTime timestamp;
  final String time;

  LastActivityModel({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.time,
  });

  factory LastActivityModel.fromJson(Map<String, dynamic> json) => LastActivityModel(
    id: json["id"],
    title: json["title"],
    timestamp: DateTime.parse(json["timestamp"]),
    time: json["time"],
  );
}

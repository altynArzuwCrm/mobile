import 'package:crm/core/utils/time_format.dart';

class CommentModel {
  final int id;
  // final int userId;
  // final dynamic projectId;
  // final int orderId;
  final String text;
  final String createdAt;
  final DateTime updatedAt;
  final String username;
  final String time;

  CommentModel({
    required this.id,
    // required this.userId,
    // required this.projectId,
    // required this.orderId,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.time,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json["id"],
    // userId: json["user_id"],
    // projectId: json["project_id"],
    // orderId: json["order_id"],
    text: json["text"],
    createdAt: json["created_at"] != null
        ? formatDate(DateTime.parse(json["created_at"]))
        : '',
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["user"]["name"],
    time: json["created_at"] != null
        ? formatTime(DateTime.parse(json["created_at"]))
        : '',
  );
}

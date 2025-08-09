class OrderModel {
  final String id;

  OrderModel({required this.id});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      OrderModel(id: json["id"]);

  Map<String, dynamic> toJson() => {"id": id};
}

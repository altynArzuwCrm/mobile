class ProductModel {
  final String id;

  ProductModel({required this.id});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(id: json["id"]);

  Map<String, dynamic> toJson() => {"id": id};
}

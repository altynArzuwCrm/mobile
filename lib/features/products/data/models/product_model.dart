class ProductModel {
  final int id;
  final String name;

  ProductModel({required this.id, required this.name});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(id: json["id"], name: json["name"]??'');

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

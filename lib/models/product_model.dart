import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String name;
  final String uid;
  final String categoryUid;
  final String brand;
  final double price;
  final int stock;
  final String description;

  ProductModel({
    required this.name,
    required this.uid,
    required this.categoryUid,
    required this.brand,
    required this.price,
    required this.stock,
    required this.description,
  });

  factory ProductModel.fromJson(json) => ProductModel(
        name: json["name"],
        uid: json["uid"],
        categoryUid: json["category_uid"],
        brand: json["brand"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "category_uid": categoryUid,
        "brand": brand,
        "price": price,
        "stock": stock,
        "description": description,
      };
}

import 'dart:convert';
// Product Model for get  Product list from fire base and it  convert json to dart 
ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? id;
  String? name;
  String? image;

  int? price;
  String? description;
  String? status;
  bool? isfavourite;
  String? categorie;
  int? qty;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.status,
    required this.isfavourite,
    required this.categorie,
    this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
         categorie: json["categorie"],
        description: json["description"],
        status: json["status"],
        isfavourite: false,
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
        "status ": status,
        "isfavourite": isfavourite,
        "categorie":categorie,
        "qty": qty
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
       categorie:categorie,
        id: id,
        name: name,
        image: image,
        price: price,
        description: description,
        status: status,
        isfavourite: false,
        qty: qty??this.qty,
      );
}

import 'dart:convert';

// Catogory Model for get  category list from fire base and it  convert json to dart 

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    String? name;
    String? id;
    String? image;

    CategoriesModel({
        required this.name,
        required this.id,
        required this.image,
    });

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        name: json["Name"],
        id: json["id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "id": id,
        "image": image,
    };
}

import 'dart:convert';
// UserModel Model for get  userlist from fire base and it  convert json to dart 
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String id;
  String? image;
  String email;

  UserModel({
  required  this.name,
   required  this.id,
 
    this.image,
   required   this.email,
});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    
        email: json["email"],
        name: json["name"],
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
       
        "email": email,
        "name": name,
        "id": id,
        "image": image,
      };


      UserModel copyWith({
   String? name,image,phone,
  }) =>
      UserModel(
      email: email,
    
        id: id,
        name: name??this.name,
        image: image??this.image,
     
      );
}

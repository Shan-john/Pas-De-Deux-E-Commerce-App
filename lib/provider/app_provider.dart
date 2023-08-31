import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/constant/routes.dart';

import 'package:screw/models/Product_model/product_model.dart';
import 'package:screw/models/User_Model/user_model.dart';

import 'package:screw/service/Firebase_Storage_helper/firebase_storage.dart';
import 'package:screw/service/firebase_firestore_helper/firebase_firestore_helper.dart';

//  Package Provider is used to handle the state change in  app

class AppProvider with ChangeNotifier {
  //initializing variables for Cart
  List<ProductModel> _cartProductList = [];

  List<ProductModel> _BuyProductList = [];
  //initializing for the usermodel
  UserModel? _userModel;
 

  //Cart Work
  //function for add Cart list to the list
  void addCartProvider(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }
  

//function forremove Cart list from the list
  void removeCartProvider(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  //passing cardProductlist using "get" keyword
  List<ProductModel> get getCartproductList => _cartProductList;

  //Favorite Work
  //function for add favorite list to the list
  List<ProductModel> _favouriteProductList = [];
  void addfavouriteProvider(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  //function for remove favorite list from the list
  void removefavouriteProvider(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

//passing favouriteProductList using "get" keyword
  List<ProductModel> get getfavouriteproductList => _favouriteProductList;

  /// User infromation
  void getUserInformationFirebase() async {
    _userModel = await FirebaseFireStoreHelper.instance.getUserInormation();
    notifyListeners();
  }

  //passing userModel using "get" keyword
  UserModel get getuserInfromation => _userModel!;

  void updateUserInfoFirebase(
      UserModel usermodel, File? file, BuildContext context) async {
    showloaderDailog(context);

    if (file == null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel.id)
          .set(usermodel.toJson());
      // Routes.instance.pop(context);
      notifyListeners();
    } else {
      String imageURl =
          await FireBaseStoragehelper.instance.uploadUserImage(file);
      _userModel = usermodel.copyWith(image: imageURl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());

      notifyListeners();
    }
    Routes.instance.pop(context);
  }
  //for

  late String _profilePictureURL;

  String get profilePictureURL => _profilePictureURL;

  set profilePictureURL(String url) {
    _profilePictureURL = url;
    notifyListeners();
  }

 // total price//
  double totalprice() {
    double totalprice = 0.0;
    for (var element in _cartProductList) {
      totalprice += element.price! * element.qty!;
    }
    return totalprice;
  }
  

  List<ProductModel> get getbuyProductlist => _BuyProductList;
  ////
  ///

 }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:screw/constant/constants.dart';

import 'package:screw/models/Categories_model/categories_Model.dart';

import 'package:screw/models/Product_model/product_model.dart';
import 'package:screw/models/User_Model/user_model.dart';

class FirebaseFireStoreHelper {
  static FirebaseFireStoreHelper instance = FirebaseFireStoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoriesModel>> getCategories() async {
    try {
      
      QuerySnapshot<Map<String, dynamic>> quertsnapshot =
          await _firebaseFirestore.collection("Categorise").get();
      List<CategoriesModel> categoriselist = quertsnapshot.docs
          .map((e) => CategoriesModel.fromJson(e.data()))
          .toList();

      return categoriselist;
    } catch (e) {
      ShowMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getproduct() async {
    try {
      QuerySnapshot<Map<String, dynamic>> quertsnapshot =
          await _firebaseFirestore.collectionGroup("Product").get();
      List<ProductModel> productlist = quertsnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productlist;
    } catch (e) {
      ShowMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryVeiw(id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> quertsnapshot =
          await _firebaseFirestore
              .collection("Categorise")
              .doc(id)
              .collection("Product")
              .get();
      List<ProductModel> productlist = quertsnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productlist;
    } catch (e) {
      ShowMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInormation() async {
    DocumentSnapshot<Map<String, dynamic>> quertsnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return UserModel.fromJson(quertsnapshot.data()!);
  }

  //// Owner number ///

  Future<void> getOwnerInformation() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('numbercollection')
          .doc('idQEp2LzDgw0piUm5kBd')
          .get();

      whatsappnumberfromfirebase = documentSnapshot['numberfield'];
      instagrammessageidfromfirebase = documentSnapshot['instagram'];
      aboutapp = documentSnapshot['aboutScreen'];
      Supportapp = documentSnapshot['supportscreen'];
    } catch (e) {
      ShowMessage(e.toString());


    }
  }
}
